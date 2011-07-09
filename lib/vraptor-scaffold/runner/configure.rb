module VraptorScaffold
  module Runner

    class Configure

      def run(args)
        plugin_name = args.first
        require plugin_name
        plugin_name.gsub('-','_').camelize.constantize.new(args).invoke_all
      end
    end
  end
end

