module VraptorScaffold
  module Runner

    # Currently only supports simple jar installation
    class Plugin

      def run(args)
        if args[0]=="install" && args.size>1
          uri = args[1]
          if uri[0..3]!="http"
            # soon... soon
            help
          else
            response = Restfulie.at(uri).get
            # TODO: put #response into a file called #{uri}.jar
            # should be done through ruby
            # save this jar file into WEB-INF/lib
          end
        else
          help
        end
      end
      
      def help
        puts "To install a plugin use:"
        puts
        # puts "vraptor plugin install plugin_name"
        puts "vraptor plugin install http://www.yourserver.com/plugin.jar"
      end

    end
  end
end
