require File.dirname(__FILE__) + '/load_paths'

module VraptorScaffold
  class Main
    
    def self.execute(args)
      action = args.shift 
      if [nil, "-h", "--help"].include?(action)
        AppGenerator.start(["-h"])
        Kernel::exit
      end
      AppGenerator.new(args.shift, args).invoke_all if action == "new"
      ScaffoldGenerator.new(args).build if action == "scaffold"
    end
    
  end
end
