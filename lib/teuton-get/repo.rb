
require_relative 'application'

class Repo

  def initialize(args)
    @config = args[:config_reader].read
    @testinfo_reader = args[:testinfo_reader]
  end

  def create(source_dir)
    puts "[INFO] Create repo for <#{source_dir}> directory"
    files = locate_filenames(source_dir)
    data = read_files(files)
    repofile = "#{source_dir}/tt-repo.yaml"

    write_repo_index(filepath: repofile, data: data)
    puts "       Creating file <#{repofile}>"
    puts "       Test number = #{data.keys.size}"
  end

  def show_list()
    puts "Show repos from config file"
    @config.each_pair do |key, value|
      if value['enable']
        puts "[ #{key} ]"
        puts "  desc : #{value['description']}"
        puts "  URL  : #{value['URL']}"
        puts
      else
        puts "[ #{key} ] (disable)".colorize(:yellow)
        puts "  desc : #{value['description']}".colorize(:yellow)
        puts "  URL  : #{value['URL']}".colorize(:yellow)
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
