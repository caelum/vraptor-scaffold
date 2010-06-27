require 'load_paths'
require 'lib/generators/app_generator'

module VraptorScaffold
  class Main
	  def self.execute(args)
	    AppGenerator.new.build(args[1]) if args[0] == "new"
    end
  end
end
