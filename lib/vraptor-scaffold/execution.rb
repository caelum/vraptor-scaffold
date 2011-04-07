module VraptorScaffold

  class Execution
    
    def run(args)
      action = args.shift
      runner_for(action).new.run(args)
    end
    
    def runner_for(action)
      VraptorScaffold::COMMANDS.fetch(action, Runner::CommandsHelp)
    end

  end

  COMMANDS = {"--help" => Runner::Help,
    "-h" => Runner::Help,
    "scaffold" => Runner::Scaffold,
    "new" => Runner::Generator
    # "plugin" => Runner::Plugin
    }

end