module VraptorScaffold
  module Runner

    class Start
      def run(args)
        if File.exist?(:src)
        else
          Kernel.puts "To run vraptor start please go to the project root folder."
        end
      end
    end
  end
end
