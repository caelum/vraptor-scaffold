require File.dirname(__FILE__) + '/load_paths'

module VraptorScaffold
  class Main
	def self.execute(args)
		  action = args.shift
	    AppGenerator.new.build(args[0]) if action == "new"
	    ScaffoldGenerator.new(args).build if action == "scaffold"
    end
  end
end
