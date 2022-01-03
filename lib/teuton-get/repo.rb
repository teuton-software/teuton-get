
require_relative 'application'

class Repo

  def initialize(args)
    @reader = args[:config_reader]
    @config = @reader.read
    @testinfo_reader = args[:testinfo_reader]
    @repoindex_writer = args[:repoindex_writer]
    @dev = args[:progress_writer]
  end

  def create(source_dir)
    @dev.writeln "[INFO] Create repo for <#{source_dir}> directory"
    files = Dir.glob(File.join(source_dir, '**', 'tt-info.yaml'))
    data = read_files(files)
    filepath = "#{source_dir}/tt-repo.yaml"

    @repoindex_writer.open(filepath)
    @repoindex_writer.write data.to_yaml
    @repoindex_writer.close

    @dev.writeln "       Creating file <#{filepath}>"
    @dev.writeln "       Test number = #{data.keys.size}"
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

  def read_files(files)
    data = {}
    files.each do |filepath|
      content = @testinfo_reader.read(filepath)
      data[filepath] = content
    end
    data
  end
end
