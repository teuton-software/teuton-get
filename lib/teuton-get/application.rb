# frozen_string_literal: true

require 'singleton'

class Application
  include Singleton

  VERSION = '0.0.0' # Application version
  NAME = 'teuton-get' # Application name

  attr_reader   :default
  attr_accessor :options

  def initialize
    reset
  end

  def reset
    @default = {}
    @options = {}
    @verbose = true
  end

  def quiet?
    return true if Application.instance.options['quiet']
    return true unless Application.instance.verbose

    false
  end
end
