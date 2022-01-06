
require_relative 'application'
require_relative 'reader/url_reader'

class Repo
  attr_reader :data

  def initialize(args)
    @reader = args[:config_reader]
    @data = @reader.read
    @testinfo_reader = args[:testinfo_reader]
    @repoindex_writer = args[:repoindex_writer]
    @dev = args[:progress_writer]
    @cache_dirpath = args[:cache_dirpath]
  end

  def create(source_dir)
    infofilename = Application::INFOFILENAME
    indexfilename = Application::INDEXFILENAME

    @dev.writeln "[INFO] Create repo for <#{source_dir}> directory"

    files = Dir.glob(File.join(source_dir, '**', infofilename))
    data = read_files(files)
    filepath = File.join(source_dir, indexfilename)
    #filepath = "#{source_dir}/#{indexfilename}"

    @repoindex_writer.open(filepath)
    @repoindex_writer.write data.to_yaml
    @repoindex_writer.close

    @dev.writeln "       Creating file <#{filepath}>"
    @dev.writeln "       Test number = #{data.keys.size}"
  end

  def show_list()
    #@dev.writeln "[INFO] Show repo list"

    rows = []
    rows << ['E', 'NAME', 'DESCRIPTION']
    rows << :separator

    @data.each_pair do |key, value|
      enable = ''
      enable = 'X' unless value['enable']
      description = value['description'] || '?'

      rows << [ enable, key, description ]
    end
    @dev.write_table(rows)
    @dev.write 'Config: '
    @dev.writeln "#{@reader.source}\n", color: :white
  end

  def refresh
    @database = {}
    dirpath = @cache_dirpath
    FileUtils.rm_r(dirpath) if Dir.exist? dirpath

    @dev.writeln '[INFO] Refresh repo'
    @data.keys.sort.each do |key|
      refresh_repo key
    end
    save_database
  end

  def database_filename()
    File.join(@cache_dirpath, 'database.yaml')
  end

  private

  def read_files(files)
    data = {}
    files.each do |filepath|
      cleanpath = filepath
      if cleanpath.start_with? './'
        # delete 2 chars at the begining. Example: "./"
        cleanpath[0,2] = ''
      end
      content = @testinfo_reader.read(cleanpath)
      dirpath = File.dirname(cleanpath)
      data[dirpath] = content
    end
    data
  end

  def refresh_repo(reponame)
    return unless enabled? reponame

    @dev.write " => Refresh repo "
    @dev.writeln "#{reponame}", color: :light_cyan

    dirpath = File.join(@cache_dirpath)
    create_dir(dirpath)
    get_database(reponame)
  end

  def enabled?(reponame)
    @data[reponame]['enable'] == true
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
    data = @data[reponame]

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
    File.write(database_filename, @database.to_yaml)
  end

end
