
require 'fileutils'

class Init

  def initialize(args)
    @dirpath = args[:dirpath]
    @filepath = args[:filepath]
    @dev = args[:writer]
  end

  def create_config()
    @dev.writeln "\n[INFO] Creating configuration files"
    create_dir
    create_ini_file
  end

  private

  def create_dir
    dirpath = @dirpath
    if Dir.exist? dirpath
      @dev.write "* Exists dir!       => "
      @dev.writeln dirpath, color: :yellow
    else
      begin
        FileUtils.mkdir_p(dirpath)
        @dev.write "* Create dir        => "
        @dev.writeln dirpath, color: :green
      rescue => e
        @dev.write "* Create dir  ERROR => "
        @dev.writeln dirpath, color: :red
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
      @dev.write "* Exists file!      => "
      @dev.writeln dest, color: :yellow
      return true
    end
    begin
      FileUtils.cp(target, dest)
      @dev.write "* Create file       => "
      @dev.writeln dest, color: :green
    rescue => e
      @dev.write "* Create file ERROR => "
      @dev.writeln dest, color: :red
      puts e
    end
  end
end
