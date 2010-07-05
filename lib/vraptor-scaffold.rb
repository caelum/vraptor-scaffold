require File.dirname(__FILE__) + '/load_paths'

module VraptorScaffold
  class Main
	  def self.execute(args)
	    action = args.delete_at(0)
	    AppGenerator.new.build(args[0]) if action == "new"
	    ScaffoldGenerator.new.build(args) if action == "scaffold"
    end
  end
end
