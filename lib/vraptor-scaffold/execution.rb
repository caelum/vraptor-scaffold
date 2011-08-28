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

  COMMANDS = {"--help" => Runner::Generator,
    "-h" => Runner::Generator,
    "new" => Runner::Generator,
    "scaffold" => Runner::Scaffold,
    "plugin" => Runner::Plugin
    #"configure" => Runner::Configure
  }
  
end
