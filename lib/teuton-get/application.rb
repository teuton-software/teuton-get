# frozen_string_literal: true

require 'singleton'
require_relative 'application/environment'
require_relative 'reader/linux_environment_reader'

class Application
  include Singleton

  VERSION    = '0.0.0'
  NAME       = 'teuton-get'
  CONFIGFILE = 'repos.ini'

  attr_reader   :default
  attr_accessor :options

  def initialize
    reset
  end

  def reset
    @default = {}
    @options = {}
    @env = Environment.new(LinuxEnvironmentReader.new)
  end

  def get(key)
    return @options[key] unless @options[key].nil?
    return @env.get(key) unless @env.get(key).nil?

    @default[key]
  end
end
