module VraptorScaffold
  module Runner

    class Configure

      def run(args)
        if VraptorScaffold::Runner::Help.help?(args.first) || args.size < 2
          puts "vraptor configure usage:"
          puts "\tvraptor configure PLUGIN_NAME"
        elsif File.exist?("src")
          plugin_name = args.first
          require plugin_name
          plugin_name.gsub('-','_').camelize.constantize.new(args).invoke_all
        else
          puts "To run vraptor plugin please go to the project root folder."
        end
      end
    end
  end
end
