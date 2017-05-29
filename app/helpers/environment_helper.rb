module EnvironmentHelper
  def e(key, default=nil)
    if ENV[key].nil?
      default
    else
      ENV[key]
    end
  end
end
