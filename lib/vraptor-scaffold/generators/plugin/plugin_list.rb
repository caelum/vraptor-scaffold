require "net/https"
require "uri"

class PluginList

  VRAPTOR_PLUGINS_URI = "https://raw.github.com/caelum/vraptor-contrib/master/.gitmodules"

  def self.show
    Kernel.system("curl --progress-bar #{VRAPTOR_PLUGINS_URI} >> .vraptor-contrib-modules")

    FileUtils.touch([".vraptor-contrib"])
    vraptor_contrib = File.open(".vraptor-contrib", "w")
    plugin_name_to_url = ""

    modules = File.readlines(".vraptor-contrib-modules")
    modules.each do |line|
      if line[/path =/]
        plugin_name = line[/= (.*)/][2..-1]
        plugin_name_to_url << plugin_name
      end
      if line[/url =/]
        plugin_address = line[/= (.*)/][2..-1]

        plugin_name_to_url << " = "
        plugin_name_to_url << plugin_address

        vraptor_contrib.puts(plugin_name_to_url)
      end
    end
  end

end
