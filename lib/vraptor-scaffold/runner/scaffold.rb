module VraptorScaffold
  module Runner

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
  end
end
