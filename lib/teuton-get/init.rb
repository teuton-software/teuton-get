
require 'fileutils'

class Init

  def initialize(args)
    @dirpath = args[:dirpath]
    @filepath = args[:filepath]
    @dev = args[:writer]
  end

  def create()
    @dev.write "\n[INFO] Creating configuration files"
    create_dir
    create_ini_file
  end

  private

  def create_dir
    dirpath = @dirpath
    if Dir.exist? dirpath
      puts "* Exists dir!       => #{dirpath.colorize(:yellow)}"
    else
      begin
        FileUtils.mkdir_p(dirpath)
        puts "* Create dir        => #{dirpath.colorize(:green)}"
      rescue => e
        puts "* Create dir  ERROR => #{dirpath.colorize(:red)}"
        puts e
      end
    end
  end

  def create_ini_file
    src = File.join(File.dirname(__FILE__), 'files', Application::CONFIGFILE)
    copyfile(src, @filepath)
  end

  def copyfile(target, dest)
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
