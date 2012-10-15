module VraptorScaffold

  class Execution

    def run(args)
      action = args.shift

      if Runner::Help.help? action
        runner_for(args.shift).new.run(["-h"])
      else
        runner_for(action).new.run(args)
      end
    end

    def runner_for(action)
      VraptorScaffold::COMMANDS.fetch(action, Runner::CommandsHelp)
    end

  end

  COMMANDS = {"new" => Runner::Generator,
              "scaffold" => Runner::Scaffold,
              "plugin" => Runner::Plugin,
              "contrib" => Runner::Contrib,
              "start" => Runner::Start
              #"configure" => Runner::Configure
  }

end
