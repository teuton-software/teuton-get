
class Environment

  def initialize(reader)
    @env = reader.read
  end

  def get(key)
    @env[key]
  end
end
