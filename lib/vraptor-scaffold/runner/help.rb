module VraptorScaffold
  module Runner

    class Help

      def self.help?(arg)
        [nil, "-h", "--help", "help"].include?(arg)
      end

    end
  end
end
