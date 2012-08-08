require "net/https"
require "uri"

class PluginList

  VRAPTOR_PLUGINS_URI = "https://raw.github.com/caelum/vraptor-contrib/master/.gitmodules"

  def self.show
    Kernel.system("curl --progress-bar #{VRAPTOR_PLUGINS_URI} >> .vraptor-contrib-modules")

    create_new_plugins_file

    vraptor_contrib = File.open(".vraptor-contrib", "w")
    modules = File.readlines(".vraptor-contrib-modules")

    plugin_name_to_url = organize_file(modules)

    vraptor_contrib.puts(plugin_name_to_url)
    vraptor_contrib.close

    FileUtils.rm(".vraptor-contrib-modules") if File.exists?(".vraptor-contrib-modules")

    YAML.load_file(".vraptor-contrib").each do |plugin|
      Kernel.puts plugin[0]
    end

    Kernel.puts "\nend."
  end

  private
  def self.create_new_plugins_file
    FileUtils.rm(".vraptor-contrib") if File.exists?(".vraptor-contrib")
    FileUtils.touch(".vraptor-contrib")
  end

  def self.organize_file(git_modules_file)
    plugin_name_to_url = ""
    git_modules_file.each do |line|
      if line[/path =/]
        plugin_name = line[/= (.*)/][2..-1]
        plugin_name_to_url << plugin_name
      end
      if line[/url =/]
        plugin_address = line[/= (.*)/][2..-1]

        plugin_name_to_url << ": "
        plugin_name_to_url << plugin_address
        plugin_name_to_url << "\n"
      end
    end

    plugin_name_to_url
  end
end
