module VraptorScaffold
  module Runner

    class Start
      def run(args)
        validate
        #%x[ant compile]
        #%x[sh $APPENGINE_SDK_HOME/bin/dev_appserver.sh #{Configuration::WEB_APP}]
        system("ant compile")
        system("sh $APPENGINE_SDK_HOME/bin/dev_appserver.sh #{Configuration::WEB_APP}")
      end

      private

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
          Kernel.puts "To run vraptor start, configure the env var APPENGINE_SDK_HOME."
          Kernel::exit
        end
      end
    end
  end
end
