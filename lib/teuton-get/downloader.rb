

require 'open-uri'

File.open('/target/path/to/downloaded.file', "wb") do |file|
  file.write open('http://example.com/your.file').read
end
