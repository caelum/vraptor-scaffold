module VraptorScaffold
  module Runner


    class Generator
      def run(args)
        project_path = args.shift
        if VraptorScaffold::Runner::Help.help? project_path
          AppGenerator.start(["-h"])
        else
          app_generators_available = {"default" => AppGenerator, "gae" => GaeAppGenerator }

          app_generator_selected = "default"
          app_generator_selected = "gae" if gae_project? args
          app_generators_available.fetch(app_generator_selected).new(project_path, args).invoke_all
        end
      end

      private
      def gae_project?(args)
        !args.grep(/--gae/).empty?
      end
    end
  end
end
