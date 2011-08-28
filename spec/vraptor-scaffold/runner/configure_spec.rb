require "spec_helper"

describe VraptorScaffold::Runner::Configure do

  xit "should print commands help" do
    args = ['simple_custom_plugin', 'extra_config']
    plugin = VraptorScaffold::Runner::Configure.new.run(args)
    plugin.invoked.should be == true
    plugin.args.should be == args
  end

end