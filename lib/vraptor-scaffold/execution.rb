module VraptorScaffold
  
  module Runner
    
    class Help
      
      def run(args)
        AppGenerator.start(["-h"])
      end
      
      def self.help?(arg)
        [nil, "-h", "--help"].include?(arg)
      end
      
    end
    
    class Scaffold
      def run(args)
        if VraptorScaffold::Runner::Help.help? args.first
          ScaffoldGenerator.start(["-h"])
        elsif File.exist?("src")
          ScaffoldGenerator.new(args).invoke_all
        else
          puts "To run vraptor scaffold please go to the project root folder."
        end
      end
    end
    
    class Generator
      def run(args)
        project_path = args.shift
        if VraptorScaffold::Runner::Help.help? project_path
          AppGenerator.start(["-h"])
        else
          AppGenerator.new(project_path, args).invoke_all
        end
      end
    end
    
    class CommandsHelp
      def run(args)
        puts "Available runners for vraptor are:"
        puts VraptorScaffold::COMMANDS.inspect
      end
    end
  end
  
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
    }

end