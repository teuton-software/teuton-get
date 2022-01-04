
require_relative 'reader/url_reader'
require_relative 'reader/yaml_reader'

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
    save_database
  end

require 'pry-byebug'
  def get(filter)
    result = []
    filename = database_filename
    @database = YamlReader.new.read(database_filename)
    @database.keys.each do |reponame|
      @database[reponame].each do |testname, data|
        if testname.include? filter
          result += [{reponame: reponame, testname: testname}]
        end
      end
    end
    result
  end

  def show(result)
    rows = []
    rows << ['REPONAME', 'TESTNAME']
    rows << :separator
    result.each { |item| rows << [item[:reponame], item[:testname]] }
    @dev.write_table(rows)
  end

  private

  def refresh_repo(reponame)
    return if enabled? reponame

    @dev.write " => Refresh repo "
    @dev.writeln "#{reponame}", color: :light_blue

    dirpath = File.join(@cache_dirpath)
    create_dir(dirpath)
    get_database(reponame)
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

  def database_filename()
    File.join(@cache_dirpath, 'database.yaml')
  end

  def save_database()
    File.write(database_filename, @database.to_yaml)
  end

end
