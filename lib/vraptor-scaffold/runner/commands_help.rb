module VraptorScaffold
  module Runner

    class CommandsHelp
      def run(args)
        puts "Available runners for vraptor are:"
        puts VraptorScaffold::COMMANDS.inspect
      end
    end
  end
end