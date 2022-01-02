
require 'pry-byebug'

class Environment
  include Singleton

  def initialize
    command = %x[env]
    lines = command.split("\n")
    @env = {}
    lines.sort.each do |line|
      items = line.split('=')
      if items.size == 2
        @env[items[0].strip] = items[1].strip
      end
    end
  end

  def get(key)
    @env[key]
  end
end
