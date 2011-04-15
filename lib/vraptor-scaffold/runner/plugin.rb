module VraptorScaffold
  module Runner

    class Plugin

      def run(args)
        if VraptorScaffold::Runner::Help.help? args.first
          PluginGenerator.start(["-h"])
        elsif File.exist?("src")
          PluginGenerator.new(args).invoke_all
        else
          puts "To run vraptor plugin please go to the project root folder."
        end
      end
    end

  end
end

