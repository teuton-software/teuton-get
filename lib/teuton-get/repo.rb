
require_relative 'application'

class Repo

  def initialize(args)
    @config = args[:config_reader].read
    @testinfo_reader = args[:testinfo_reader]
    @writer = args[:writer]
  end

  def create(source_dir)
    @writer.write "[INFO] Create repo for <#{source_dir}> directory"
    files = locate_filenames(source_dir)
    data = read_files(files)
    repofile = "#{source_dir}/tt-repo.yaml"

    write_repo_index(filepath: repofile, data: data)
    @writer.write "       Creating file <#{repofile}>"
    @writer.write "       Test number = #{data.keys.size}"
  end

  def show_list()
    @writer.write "Show repos from config file"
    @config.each_pair do |key, value|
      if value['enable']
        @writer.write "[ #{key} ]"
        @writer.write "  desc : #{value['description']}"
        @writer.write "  URL  : #{value['URL']}"
        @writer.write
      else
        @writer.write "[ #{key} ] (disable)", color: :yellow
        @writer.write "  desc : #{value['description']}", color: :yellow
        @writer.write "  URL  : #{value['URL']}", color: :yellow
        puts
      end
    end
  end

  private

  def self.locate_filenames(source_dir)
    Dir.glob('**/tt-info.yaml')
  end

  def read_files(files)
    data = {}
    files.each do |filepath|
      content = @testinfo_reader.read(filepath)
      data[filepath] = content
    end
    data
  end

  def write_repo_index(args)
    filepath = args[:filepath]
    data = args[:data]

    file = File.open(filepath, 'w')
    file.write data.to_yaml
    file.close
  end
end
