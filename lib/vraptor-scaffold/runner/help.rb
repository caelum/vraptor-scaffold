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
  end
end