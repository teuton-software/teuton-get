
require 'yaml'
require 'inifile'
require_relative 'application'

module Repo
  def self.create(source_dir)
    puts "[INFO] Create repo for <#{source_dir}> directory"
    files = locate_filenames(source_dir)
    data = read_files(files)
    repofile = "#{source_dir}/tt-repo.yaml"

    write_repo_index(filepath: repofile, data: data)
    puts "       Creating file <#{repofile}>"
    puts "       Test number = #{data.keys.size}"
  end

  private_class_method def self.locate_filenames(source_dir)
    Dir.glob('**/tt-info.yaml')
  end

  private_class_method def self.read_files(files)
    data = {}
    files.each do |filepath|
      content = YAML.load(File.open(filepath))
      data[filepath] = content
    end
    data
  end

  private_class_method def self.write_repo_index(args)
    filepath = args[:filepath]
    data = args[:data]

    file = File.open(filepath, 'w')
    file.write data.to_yaml
    file.close
  end

  def self.show_list()
    puts "Show repos from config file"
    data = read_inifile
    data.each_pair do |key, value|
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

  def self.read_inifile()
    home = Environment.instance.get('HOME')
    configfile = Application::CONFIGFILE
    inifile = IniFile.load("#{home}/.teuton/#{configfile}")
    data = {}
    inifile.sections.each do |section|
      data[section] = inifile[section]
    end
    data
  end
end
