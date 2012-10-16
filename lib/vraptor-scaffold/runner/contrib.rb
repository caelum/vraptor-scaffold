module VraptorScaffold

  module Runner

    class Contrib
      def run(args)
        validate

        contrib_options = {"list" => ContribList,
                           "install" => ContribInstaller}

        option_selected = args.shift

        contrib_options.fetch(option_selected, ContribList).new(args).invoke_all
      end

      private
      def validate
        unless File.exist?("src")
          Kernel.puts("To run vraptor contrib please go to the project root folder.")
          Kernel::exit
        end
      end

    end
  end
end

