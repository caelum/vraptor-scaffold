module VraptorScaffold
  module Runner

    class Configure

      def run(args)
        if VraptorScaffold::Runner::Help.help?(args.first) || args.size < 2
          Kernel.puts "vraptor configure usage:"
          Kernel.puts "\tvraptor configure PLUGIN_NAME"
        else
          plugin_name = args.first
          require plugin_name
          puts "Configuring plugin '#{plugin_name}'"
          plugin = plugin_name.gsub('-','_').camelize.constantize.new(args)
          plugin.invoke_all
          plugin
        end
      end
    end
  end
end
