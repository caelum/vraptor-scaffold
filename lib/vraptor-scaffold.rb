require File.dirname(__FILE__) + '/load_paths'

module VraptorScaffold
  class Main

    def self.execute(args)
      action = args.shift
      print_help(AppGenerator) if help? action
      run_app_generator(args.shift, args) if action == "new"
      run_scaffold_generator(args) if action == "scaffold"
    end

    def self.run_app_generator(project_path, args)
      print_help(AppGenerator) if help? project_path
      AppGenerator.new(project_path, args).invoke_all
    end

    def self.run_scaffold_generator(args)
      print_help(ScaffoldGenerator) if help? args.first
      unless File.exist?("src")
        puts "To run vraptor scaffold please go to the project root folder."
        Kernel::exit
      end
      ScaffoldGenerator.new(args).invoke_all 
    end

    def self.print_help(generator)
      generator.start(["-h"])
      Kernel::exit
    end

    def self.help?(command)
      [nil, "-h", "--help"].include?(command)
    end    
  end
end
