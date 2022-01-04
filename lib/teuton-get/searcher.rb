
require_relative 'reader/url_reader'

class Searcher
  def initialize(args)
    @cache_dirpath = args[:cache_dirpath]
    @repo = args[:repo]
    @dev = args[:writer]
    @reader = args[:reader]
    @database = {}
  end

  def refresh
    @database = {}
    dirpath = @cache_dirpath
    FileUtils.rm_r(dirpath) if Dir.exist? dirpath

    @dev.writeln '[INFO] Refresh repo'
    @repo.data.keys.sort.each do |key|
      refresh_repo key
    end
  end

  private

  def refresh_repo(reponame)
    return if enabled? reponame

    @dev.write " => Refresh repo "
    @dev.writeln "#{reponame}", color: :light_blue

    dirpath = File.join(@cache_dirpath)
    create_dir(dirpath)
    get_database(reponame)
    save_database
  end

  def enabled?(reponame)
    @repo.data[reponame]['enable'] == false
  end

  def create_dir(dirpath)
    unless Dir.exist? dirpath
      begin
        FileUtils.mkdir_p(dirpath)
      rescue => e
        @dev.write "* Create dir  ERROR => "
        @dev.writeln dirpath, color: :red
        puts e
      end
    end
  end

  def get_database(reponame)
    data = @repo.data[reponame]

    if data["URL"].start_with? 'http'
      @database[reponame] = get_remote_database(data["URL"])
    else
      @database[reponame] = get_local_database(data["URL"])
    end
  end

  def get_local_database(dirpath)
    filepath = File.join(dirpath, Application::INDEXFILENAME)
    @reader.read(filepath)
  end

  def get_remote_database(url_repo)
    url_file = "#{url_repo}/#{Application::INDEXFILENAME}"
    content_page = URLReader.new(url_file).read
    yaml_content = YAML::load(content_page)
  end

  def save_database()
    filename = File.join(@cache_dirpath, 'database.yaml')
    File.write(filename, @database.to_yaml)
  end
end
