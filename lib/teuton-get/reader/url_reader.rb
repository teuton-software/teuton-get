require "net/http"
require "uri"
require_relative "reader"

class URLReader < Reader
  def initialize(url = "")
    @url = url
  end

  def source
    @url
  end

  def read(url = :default)
    @url = url unless url == :default
    Net::HTTP.get(URI.parse(@url))
  end
end
