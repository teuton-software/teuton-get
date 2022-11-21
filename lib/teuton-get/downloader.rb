require "fileutils"
require "tty-progressbar"
require_relative "writer/file_writer"
require_relative "writer/terminal_writer"
require_relative "reader/inifile_reader"
require_relative "reader/url_reader"
require_relative "repo/repo_config"
require_relative "repo/repo_data"

class Downloader
  def initialize
    @dev = TerminalWriter.new
    @repo_config = RepoConfig.new_by_default.data
    cache_dirpath = Application.instance.get(:cache_dirpath)
    @repo_data = RepoData.new(
      config_reader: IniFileReader.new,
      progress_writer: TerminalWriter.new,
      cache_dirpath: cache_dirpath
    )
  end

  def run(id)
    reponame, testpath = id.split(Application::SEPARATOR)

    repo_url, status = get_url_for reponame
    unless status == :ok
      @dev.writeln "    #{status}"
      return false
    end

    files, status = get_files_for_test id
    unless status == :ok
      @dev.writeln "    #{status}"
      return false
    end

    download(reponame, repo_url, testpath, files)
  end

  private

  def get_url_for(reponame)
    repo = @repo_config[reponame]
    return nil, "ERROR: undefined repo name!" if repo.nil?
    url = repo["URL"]
    return nil, "ERROR: undefined repo URL!" if url.nil?
    [url, :ok]
  end

  def get_files_for_test(id)
    testdata = @repo_data.get(id)
    return [], "ERROR: not found!" if testdata.nil?
    files = testdata["files"]
    return [], "WARN: files no defined!" if files.nil?
    return [], "WARN: 0 files defined!" if files.size.zero?
    [files, :ok]
  end

  def download(reponame, url, path, files)
    bar = TTY::ProgressBar.new("==> Progress [:bar] :percent", total: files.size, bar_format: :block)

    localpath = path.tr("/", "_")
    FileUtils.mkdir(localpath) unless File.exist? localpath
    files.each do |filename|
      bar.advance

      uri = "#{url}/#{path}/#{filename}"
      out = FileWriter.new
      out.open(File.join(localpath, filename))
      out.write(URLReader.new(uri).read)
      out.close
    end
    @dev.writeln "==> Download OK", color: :white
  end
end
