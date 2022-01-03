
require_relative 'reader'

class LinuxEnvironmentReader < Reader

  def initialize(command)
    @command = command
  end

  def read()
    lines = @command.split("\n")
    data = {}
    lines.sort.each do |line|
      items = line.split('=')
      if items.size == 2
        data[items[0].strip] = items[1].strip
      end
    end
    data
  end
end
