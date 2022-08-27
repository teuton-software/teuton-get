require "yaml"
require_relative "../application"
require_relative "../reader/url_reader"
require_relative "../reader/yaml_reader"

class RepoData
  attr_reader :data

  def initialize(args)
    @reader = args[:config_reader]
    @data = @reader.read
    @dev = args[:progress_writer]
    @cache_dirpath = args[:cache_dirpath]
  end

  def refresh
    @database = {}
    dirpath = @cache_dirpath
    FileUtils.rm_r(dirpath) if Dir.exist? dirpath

    @dev.writeln "\n==> Refreshing active repos", color: :light_yellow
    @data.keys.sort.each do |key|
      refresh_repo key
    end
    save_database
  end

  def get(test_id)
    reponame, id = test_id.split("@")
    database = YamlReader.new.read(database_filename)
    database[reponame][id]
  end

  def show_testinfo(item)
    return unless item
    # Show info
    @dev.writeln ""
    @dev.writeln "name   : #{item["name"]}"
    @dev.writeln "author : #{item["author"]}"
    @dev.writeln "date   : #{item["date"]}"
    @dev.writeln "desc   : #{item["desc"]}"
    @dev.writeln "tags   : #{item["tags"].join(", ")}"
  end

  def database_filename
    # REVISE: Used by teutonget search... replace by #get()
    File.join(@cache_dirpath, "database.yaml")
  end

  private

  def refresh_repo(reponame)
    unless enabled? reponame
      @dev.write "    Skiping repo "
      @dev.writeln reponame.to_s, color: :light_red
      return false
    end
    dirpath = File.join(@cache_dirpath)
    ok1 = create_dir(dirpath)
    ok2 = get_database(reponame)

    @dev.write "    Repo "
    @dev.write reponame.to_s, color: :light_cyan
    @dev.writeln " (#{ok2.size} tests)"

    true && ok1 && ok2
  end

  def enabled?(reponame)
    @data[reponame]["enable"] == true
  end

  def create_dir(dirpath)
    unless Dir.exist? dirpath
      begin
        FileUtils.mkdir_p(dirpath)
        return true
      rescue => e
        @dev.write "* Create dir  ERROR => "
        @dev.writeln dirpath, color: :red
        puts e
        return false
      end
    end
    false
  end

  def get_database(reponame)
    data = @data[reponame]

    @database[reponame] = if data["URL"].start_with? "http"
      get_remote_database(data["URL"])
    else
      get_local_database(data["URL"])
    end
  end

  def get_local_database(dirpath)
    filepath = File.join(dirpath, Application::INDEXFILENAME)
    @reader.read(filepath)
  end

  def get_remote_database(url_repo)
    url_file = "#{url_repo}/#{Application::INDEXFILENAME}"
    content_page = URLReader.new(url_file).read
    YAML.safe_load(
      content_page,
      permitted_classes: [Array, Date, Hash, Symbol]
    )
  end

  def save_database
    File.write(database_filename, @database.to_yaml)
  end
end
