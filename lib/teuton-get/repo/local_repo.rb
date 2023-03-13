require_relative "../settings"
require_relative "../writer/file_writer"
require_relative "../writer/terminal_writer"

# Create metadata for local user teuton repository
class LocalRepo
  def initialize(args)
    @repoindex_writer = args[:repoindex_writer]
    @dev = args[:progress_writer]
  end

  def self.default
    LocalRepo.new(
      repoindex_writer: FileWriter.new,
      progress_writer: TerminalWriter.new
    )
  end

  def create(dirpath)
    infofilename = Settings::INFOFILENAME
    infofiles = Dir.glob(File.join(dirpath, "**", infofilename))
    return if infofiles.size.zero?

    @dev.writeln "\n==> Creating repository", color: :light_yellow
    data = read_files(infofiles)

    filepath = File.join(dirpath, Settings::INDEXFILENAME)
    @repoindex_writer.open(filepath)
    @repoindex_writer.write data.to_yaml
    @repoindex_writer.close

    @dev.writeln "    Created file #{filepath} with #{data.keys.size} tests.", color: :white
    true
  end

  private

  def read_files(infofiles)
    data = {}
    infofiles.each do |filepath|
      cleanpath = filepath
      if cleanpath.start_with? "./"
        # delete 2 chars at the begining. Example: "./"
        cleanpath[0, 2] = ""
      end
      infodata = LocalInfo.new(@dev).read(cleanpath)
      dirpath = File.dirname(cleanpath)
      data[dirpath] = infodata
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
