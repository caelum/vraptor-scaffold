module VraptorScaffold
  module Runner

    class Plugin

      def run(args)
        plugin_option = args.shift

        if VraptorScaffold::Runner::Help.help?(plugin_option)
          PluginGenerator.start(["-h"])
        elsif File.exist?("src")
          PluginGenerator.new(plugin_option, args).invoke_all
        else
          puts "To run vraptor plugin please go to the project root folder."
        end
      end
    end

  end
end

