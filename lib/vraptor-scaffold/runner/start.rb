module VraptorScaffold
  module Runner

    class Start
      def run(args)
        if args != nil
          if Runner::Help.help? args.shift
            help
            return
          end
        end

        validate
        Kernel.system("ant vraptor-scanning")
        Kernel.system("sh $APPENGINE_SDK_HOME/bin/dev_appserver.sh #{Configuration::WEB_APP}")
      end

      private

      def help
          Kernel.puts "  vraptor start is available only for appengine apps."
          Kernel.puts "  you should configure environment variable APPENGINE_SDK_HOME."
          Kernel.puts "  To run vraptor start please go to the project root folder."
          Kernel.puts ""
      end

      def validate
        unless File.exist?("src")
          Kernel.puts "To run vraptor start please go to the project root folder."
          Kernel::exit
        end
        unless Configuration.orm == "objectify"
          Kernel.puts "vraptor start command is available only for gae apps."
          Kernel::exit
        end
        unless ENV['APPENGINE_SDK_HOME']
          Kernel.puts "To run vraptor start, configure environment variable APPENGINE_SDK_HOME."
          Kernel::exit
        end
      end
    end
  end
end
