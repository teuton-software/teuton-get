
require_relative 'application'

class Repo

  def initialize(args)
    @config = args[:config_reader].read
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

require 'pry-byebug'
  def show_list()
    @dev.writeln "Show repos from config file"
    @config.each_pair do |key, value|
      if value['enable']
        @dev.writeln "[ #{key} ]"
        @dev.writeln "  desc : #{value['description']}"
        @dev.writeln "  URL  : #{value['URL']}"
        @dev.writeln
      else
        @dev.writeln "[ #{key} ] (disable)", color: :yellow
        @dev.writeln "  desc : #{value['description']}", color: :yellow
        @dev.writeln "  URL  : #{value['URL']}", color: :yellow
        @dev.writeln
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
