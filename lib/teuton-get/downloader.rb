# require "open-uri"
require_relative "writer/terminal_writer"
require_relative "repo/repo_config"
require "open-uri"

module Downloader
  def self.run(id)
    reponame, testpath = id.split("@")
    repolist = RepoConfig.new_by_default.data
    repourl = repolist[reponame]["URL"]
    debug(reponame, testpath, repourl)
    url = "#{repourl}/#{testpath}/start.rb"
    get(url)
  end

  def self.debug(reponame, testpath, url)
    dev = TerminalWriter.new
    dev.writeln("==> Downloading...")
    dev.writeln("    reponame = #{reponame}")
    dev.writeln("    testpath = #{testpath}")
    dev.writeln("    URL repo = #{url}")
  end

  def self.get(uri)
    URI.open(uri) do |remotefile|
      puts remotefile.read
      # File.open("./test.jpg", "wb") do |file|
      #  file.write(image.read)
      # end
    end
  end
end
