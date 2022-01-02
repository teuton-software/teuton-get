
require 'colorize'
require_relative 'environment'

module Init
  def self.create()
    puts "\n[INFO] Creating configuration files"
    home = Environment.instance.get('HOME')
    dirpath = "#{home}/.teuton"
    create_dir(dirpath)
    create_ini_file(dirpath)
  end

  private_class_method def self.create_dir(dirpath)
    if Dir.exist? dirpath
      puts "* Exists dir!       => #{dirpath.colorize(:yellow)}"
    else
      begin
        FileUtils.mkdir_p(dirpath)
        puts "* Create dir        => #{dirpath.colorize(:green)}"
      rescue StandardError
        puts "* Create dir  ERROR => #{dirpath.colorize(:red)}"
      end
    end
  end

  private_class_method def self.create_ini_file(dirpath)
    src = File.join(File.dirname(__FILE__), 'files', Application::CONFIGFILE)
    dst = File.join(dirpath, Application::CONFIGFILE)
    copyfile(src, dst)
  end

  private_class_method def self.copyfile(target, dest)
    if File.exist? dest
      puts "* Exists file!      => #{dest.colorize(:yellow)}"
      return true
    end
    begin
      FileUtils.cp(target, dest)
      puts "* Create file       => #{dest.colorize(:green)}"
    rescue StandardError
      puts "* Create file ERROR => #{dest.colorize(:red)}"
    end
  end
end
