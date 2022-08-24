# require "open-uri"
require_relative "writer/terminal_writer"
require_relative "repo/repo_config"
require "open-uri"

class Downloader
  def initialize
    @dev = TerminalWriter.new
    @dev.writeln("==> Downloading...")
  end

  def run(id)
    reponame, testpath = id.split("@")
    repolist = RepoConfig.new_by_default.data
    repourl = repolist[reponame]["URL"]
    debug(reponame, testpath, repourl)

    filename = "start.rb"
    @dev.writeln("==> File: #{filename}")
    uri = "#{repourl}/#{testpath}/#{filename}"
    get(uri)
  end

  def debug(reponame, testpath, url)
    @dev.writeln("    reponame = #{reponame}")
    @dev.writeln("    testpath = #{testpath}")
    @dev.writeln("    URL repo = #{url}")
  end

  def get(uri)
    URI.open(uri) do |f|
      puts f.read
      # File.open("./test.jpg", "wb") do |file|
      #  file.write(image.read)
      # end
    end
  end
end
