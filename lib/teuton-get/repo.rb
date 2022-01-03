
require_relative 'application'

class Repo
  attr_reader :data

  def initialize(args)
    @reader = args[:config_reader]
    @data = @reader.read
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
