module VraptorScaffold
  module Runner

    class CommandsHelp
      def run(args)
        puts_main_help
      end

      private
      def puts_main_help
        Kernel.puts "Available runners for vraptor are: #{VraptorScaffold::COMMANDS.keys.join(', ')}"
        Kernel.puts ""
        Kernel.puts "Usage:"
        Kernel.puts "  vraptor runner"
        Kernel.puts ""
        Kernel.puts "Getting help:"
        Kernel.puts "  vraptor help runner"
        Kernel.puts ""
      end

    end



  end
end
