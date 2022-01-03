
require_relative 'application'

class Repo

  def initialize(args)
    @reader = args[:config_reader]
    @config = @reader.read
    @testinfo_reader = args[:testinfo_reader]
    @dev = args[:writer]
  end

  def create(source_dir)
    @dev.write "[INFO] Create repo for <#{source_dir}> directory"
    files = locate_filenames(source_dir)
    data = read_files(files)
    repofile = "#{source_dir}/tt-repo.yaml"

    write_repo_index(filepath: repofile, data: data)
    @dev.write "       Creating file <#{repofile}>"
    @dev.write "       Test number = #{data.keys.size}"
  end

  def show_list()
    @dev.write "[INFO] Show repo list from "
    @dev.writeln "#{@reader.source}\n", color: :light_blue

    @config.each_pair do |key, value|
      if value['enable']
        @dev.write '*', color: :light_green
        @dev.writeln " #{key}"
        @dev.write "    ├─ desc : "
        @dev.writeln "#{value['description']}"
        @dev.write "    └─ URL  : "
        @dev.writeln "#{value['URL']}"
      else
        @dev.write 'X', color: :light_red
        @dev.write  " #{key} "
        @dev.writeln "(disable)", color: :light_red
        @dev.writeln "    ├─ desc : #{value['description']}"
        @dev.writeln "    └─ URL  : #{value['URL']}"
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
