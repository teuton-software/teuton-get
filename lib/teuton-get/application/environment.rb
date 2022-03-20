
class Environment

  def initialize(reader=nil)
    #@env = reader.read
    @env = ENV
  end

  def get(key)
    @env[key]
  end
end
