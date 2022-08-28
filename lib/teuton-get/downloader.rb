# require "open-uri"
require_relative "writer/terminal_writer"
require_relative "repo/repo_config"
require "open-uri"

class Downloader
  def initialize
    @dev = TerminalWriter.new
  end

  def run(id)
    reponame, testpath = id.split(Application::SEPARATOR)
    repolist = RepoConfig.new_by_default.data
    repourl = repolist[reponame]["URL"]
    files = repolist[reponame]["files"]
    return if files.nil?

    @dev.writeln "==> Downloading...", color: :light_yellow
    filename = "start.rb"
    @dev.writeln("==> File: #{filename}")
    uri = "#{repourl}/#{testpath}/#{filename}"
    get(uri)
  end

  def debug(reponame, testpath, url)
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
