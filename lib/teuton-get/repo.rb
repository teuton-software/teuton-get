
require_relative 'application'

# Create repo dir data and info file data
class Repo
  def initialize(args)
    @testinfo_reader  = args[:testinfo_reader]
    @repoindex_writer = args[:repoindex_writer]
    @dev = args[:progress_writer]
  end

  def create_repo(source_dir)
    infofilename = Application::INFOFILENAME
    indexfilename = Application::INDEXFILENAME

    @dev.write "\nCreate repo into folder "
    @dev.writeln source_dir, color: :light_cyan

    files = Dir.glob(File.join(source_dir, '**', infofilename))
    data = read_files(files)
    filepath = File.join(source_dir, indexfilename)

    @repoindex_writer.open(filepath)
    @repoindex_writer.write data.to_yaml
    @repoindex_writer.close

    @dev.write " => Creating file: "
    @dev.writeln filepath, color: :light_cyan
    @dev.writeln "    Tests counter: #{data.keys.size}"
  end

  def create_info(testpath)
    startfile = File.join(testpath, 'start.rb')
    unless File.exist?(startfile)
      @dev.writeln "[ERROR] File start.rb not found!", color: :light_red
      return
    end

    @dev.write "\nCreate info for "
    @dev.writeln testpath, color: :light_cyan
    infofilename = Application::INFOFILENAME
    target = File.join(testpath, infofilename)
    source = File.join(File.dirname(__FILE__), 'files', infofilename)
    copyfile(source, target)
  end

  private

  def read_files(files)
    data = {}
    files.each do |filepath|
      cleanpath = filepath
      if cleanpath.start_with? './'
        # delete 2 chars at the begining. Example: "./"
        cleanpath[0,2] = ''
      end
      content = @testinfo_reader.read(cleanpath)
      dirpath = File.dirname(cleanpath)
      data[dirpath] = content
    end
    data
  end

  def copyfile(target, dest)
    if File.exist? dest
      @dev.write "  * Exists file! : "
      @dev.writeln dest, color: :light_yellow
      return true
    end
    begin
      FileUtils.cp(target, dest)
      @dev.write " => Create file : "
      @dev.writeln dest, color: :light_green
    rescue => e
      @dev.write " => Create file ERROR: "
      @dev.writeln dest, color: :light_red
      puts e
    end
  end
end
