require "net/https"
require "uri"

class PluginList

  VRAPTOR_PLUGINS_URI = "https://raw.github.com/caelum/vraptor-contrib/master/.gitmodules"

  def self.fetch
    Kernel.system("curl --progress-bar #{VRAPTOR_PLUGINS_URI} >> .vraptor-contrib")
  end

end
