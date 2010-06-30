require File.dirname(__FILE__) + '/load_paths'
require File.dirname(__FILE__) + '/../lib/generators/app_generator'

module VraptorScaffold
  class Main
	  def self.execute(args)
	    AppGenerator.new.build(args[1]) if args[0] == "new"
    end
  end
end
