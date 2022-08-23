class Environment
  def initialize(reader = nil)
    @env = ENV
  end

  def get(key)
    @env[key]
  end
end
