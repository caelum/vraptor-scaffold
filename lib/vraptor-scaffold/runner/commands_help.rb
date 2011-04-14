module VraptorScaffold
  module Runner

    class CommandsHelp
      def run(args)
        Kernel.puts "Available runners for vraptor are: #{VraptorScaffold::COMMANDS.keys.join(', ')}"
        Kernel.puts "Usage:"
        Kernel.puts "  vraptor runner"
      end
    end

  end
end