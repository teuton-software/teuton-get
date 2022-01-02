
require_relative 'environment'

module Init
  def self.create()
    puts Environment.instance.get('HOME')
    puts Environment.instance.get('USER')
  end
end
