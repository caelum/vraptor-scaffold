require "net/https"
require "uri"

class PluginList

  VRAPTOR_PLUGINS_URI = "https://raw.github.com/caelum/vraptor-contrib/master/.gitmodules"

  def self.fetch
    Kernel.system("curl --progress-bar #{VRAPTOR_PLUGINS_URI} >> .vraptor-contrib-modules")

    modules = File.readlines(".vraptor-contrib-modules")
    modules.each do |line|
      if line[/path =/]
        plugin_name = line[/= (.*)/][2..-1]
        Kernel.puts(plugin_name)
      end
      if line[/url =/]
        plugin_address = line[/= (.*)/][2..-1]
        Kernel.puts(plugin_address)
      end
    end

  end

  def self.show
  end

end
