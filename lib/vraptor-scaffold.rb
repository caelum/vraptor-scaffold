require File.dirname(__FILE__) + '/load_paths'

module VraptorScaffold
  class Main
    def self.execute(args)
      action = args.shift
      AppGenerator.new(args[0]).invoke if action == "new"
      ScaffoldGenerator.new(args).build if action == "scaffold"
      exec("mvn compile war:inplace jetty:run") if action == "start"
    end
  end
end
