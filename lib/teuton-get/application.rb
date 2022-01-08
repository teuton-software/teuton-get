# frozen_string_literal: true

require 'singleton'
require_relative 'application/environment'
require_relative 'reader/linux_environment_reader'

class Application
  include Singleton

  VERSION       = '0.0.0'
  NAME          = 'teuton-get'
  CONFIGFILE    = 'repos.ini'
  INDEXFILENAME = 'tt-repo.yaml'
  INFOFILENAME  = 'tt-info.yaml'
  MAGICNUMBER   = 999

  def initialize
    @env = Environment.new(LinuxEnvironmentReader.new(%x[env]))
    @params = {}
    init_params
  end

  def get(key)
    return @env.get(key) if key.class == String

    @params[key] || 'NODATA'
  end

  private

  def init_params()
    home = get('HOME')
    filename = Application::CONFIGFILE
    configpath = "#{home}/.teuton/#{filename}"
    @params[:configpath] = configpath

    cache_dirpath = "#{home}/.teuton/cache"
    @params[:cache_dirpath] = cache_dirpath
  end
end
