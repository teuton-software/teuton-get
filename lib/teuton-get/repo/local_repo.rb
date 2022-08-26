require_relative "../application"

class LocalRepo
  def initialize(args)
    @repoindex_writer = args[:repoindex_writer]
    @dev = args[:progress_writer]
  end

  def create_repo(source_dir)
    infofilename = Application::INFOFILENAME
    indexfilename = Application::INDEXFILENAME

    @dev.write "\n==> Create repo into folder "
    @dev.writeln source_dir, color: :light_cyan

    files = Dir.glob(File.join(source_dir, "**", infofilename))
    data = read_files(files)
    filepath = File.join(source_dir, indexfilename)

    @repoindex_writer.open(filepath)
    @repoindex_writer.write data.to_yaml
    @repoindex_writer.close

    @dev.write "==> Creating file: "
    @dev.writeln filepath, color: :light_cyan
    @dev.writeln "    Tests counter: #{data.keys.size}"
    true
  end

  private

  def read_files(files)
    data = {}
    files.each do |filepath|
      cleanpath = filepath
      if cleanpath.start_with? "./"
        # delete 2 chars at the begining. Example: "./"
        cleanpath[0, 2] = ""
      end
      content = LocalInfo.new.read(cleanpath)
      dirpath = File.dirname(cleanpath)
      data[dirpath] = content
    end
    data
  end

  def copyfile(target, dest)
    if File.exist? dest
      @dev.write "    WARN: exits file "
      @dev.writeln dest, color: :light_yellow
      return true
    end
    begin
      FileUtils.cp(target, dest)
      @dev.write "===> Created file "
      @dev.writeln dest, color: :light_green
      true
    rescue => e
      @dev.write "    ERROR: Creating file "
      @dev.writeln dest, color: :light_red
      puts e
      false
    end
  end
end
