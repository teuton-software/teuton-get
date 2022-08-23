require "open-uri"

module Downloader
  def self.get(url)
    file = File.binwrite("/target/path/to/downloaded.file2")
    file.write open("http://example.com/your.file").read
  end
end
