require File.dirname(__FILE__) + '/load_paths'
require File.dirname(__FILE__) + '/../lib/generators/app_generator'
require File.dirname(__FILE__) + '/../lib/generators/scaffold_generator'

module VraptorScaffold
  class Main
	  def self.execute(args)
	    action = args.delete_at(0)
	    AppGenerator.new.build(args[0]) if action == "new"
	    ScaffoldGenerator.new.build(args) if action == "scaffold"
    end
  end
end
