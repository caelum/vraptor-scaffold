module VraptorScaffold
  module Runner

    class Contrib

      def run(args)
        validate
        contrib_option = args.shift

        if contrib_option.eql? "list"
          ContribList.show
        elsif contrib_option.eql? "install"
          ContribInstaller.new(contrib_option, args).invoke_all
        end
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

