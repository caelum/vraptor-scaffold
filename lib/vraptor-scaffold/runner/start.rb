module VraptorScaffold
  module Runner

    class Start
      def run(args)
        validate
      end

      private

      def validate
        unless File.exist?(:src)
          Kernel.puts "To run vraptor start please go to the project root folder." 
          Kernel::exit
        end
        unless Configuration.orm == "objectify"
          Kernel.puts "vraptor start command is available only for gae apps"
          Kernel::exit
        end
      end
    end
  end
end
