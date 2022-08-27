require_relative "../application"
# filepaths = Dir.glob("#{testpath}/**/*.*")
# _files = filepaths.map { |i| i[testpath.size + 1, i.size] } - [infofilename]

class LocalRepo
  def initialize(args)
    @repoindex_writer = args[:repoindex_writer]
    @dev = args[:progress_writer]
  end

  def create(dirpath)
    infofilename = Application::INFOFILENAME
    infofiles = Dir.glob(File.join(dirpath, "**", infofilename))
    return if infofiles.size.zero?

    @dev.writeln "\n==> Creating repository", color: :light_yellow
    data = read_files(infofiles)

    filepath = File.join(dirpath, Application::INDEXFILENAME)
    @repoindex_writer.open(filepath)
    @repoindex_writer.write data.to_yaml
    @repoindex_writer.close

    @dev.write "    File: "
    @dev.write filepath, color: :light_cyan
    @dev.writeln " (#{data.keys.size} tests)"
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
