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
  end

  def get(key)
    return @env.get(key) if key.class == String

    @params[key]
  end
end
