# require "open-uri"
require_relative "writer/terminal_writer"
require_relative "reader/inifile_reader"
require_relative "repo/repo_config"
require_relative "repo/repo_data"
require "open-uri"

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

    repo_url, status = get_url(reponame)
    unless status == :ok
      @dev.writeln "    #{status}"
      return false
    end

    files, status = get_files(reponame)
    unless status == :ok
      @dev.writeln "    #{status}"
      return false
    end

    @dev.writeln "==> Downloading...", color: :light_yellow
    filename = files[0]
    @dev.writeln("==> File: #{filename}")
    uri = "#{repo_url}/#{testpath}/#{filename}"
    get(uri)
  end

  def get(uri)
    URI.open(uri) do |f|
      # File.open("./test.jpg", "wb") do |file|
      #   file.write(image.read)
      # end
    end
  end

  private

  def get_url(reponame)
    repo = @repo_config[reponame]
    return nil, "ERROR: undefined repo name!" if repo.nil?
    url = repo["URL"]
    return nil, "ERROR: undefined repo URL!" if url.nil?
    [url, :ok]
  end

  def get_files(id)
    info = @repo_data.get(id)
    return [], "ERROR: not found!" if info.nil?
    files = info["files"]
    return [], "WARN: files no defined!" if files.nil?
    return [], "WARN: 0 files defined!" if files.size.zero?
    [files, :ok]
  end
end
