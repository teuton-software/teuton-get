

61

You can do the same without OpenURI:

require 'net/http'
require 'uri'

def open(url)
  Net::HTTP.get(URI.parse(url))
end

page_content = open('http://www.google.com')
puts page_content

Or, more succinctly:

Net::HTTP.get(URI.parse('http://www.google.com'))
