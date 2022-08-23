require "singleton"
require_relative "application/environment"

class Application
  include Singleton

  CONFIGFILE = "repos.ini"
  INDEXFILENAME = "tt-repo.yaml"
  INFOFILENAME = "tt-info.yaml"
  MAGICNUMBER = 999

  def initialize
    @env = Environment.new
    init_params
  end

  def get(key)
    return @env.get(key) if key.instance_of? String

    @params[key] || "NODATA"
  end

  private

  def init_params
    @params = {}
    home = get("HOME")
    config_dirpath = File.join(home, ".config", "teuton")
    @params[:config_dirpath] = config_dirpath

    filename = Application::CONFIGFILE
    config_filepath = File.join(config_dirpath, filename)
    @params[:config_filepath] = config_filepath

    cache_dirpath = File.join(config_dirpath, "cache")
    @params[:cache_dirpath] = cache_dirpath
  end
end
