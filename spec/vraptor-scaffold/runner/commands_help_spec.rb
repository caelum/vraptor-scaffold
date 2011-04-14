require "spec_helper"

describe VraptorScaffold::Runner::CommandsHelp do

  it "should print commands help" do
    Kernel.should_receive(:puts).with("Available runners for vraptor are: #{VraptorScaffold::COMMANDS.keys.join(', ')}")
    Kernel.should_receive(:puts).with("Usage:")
    Kernel.should_receive(:puts).with("  vraptor runner")
    VraptorScaffold::Runner::CommandsHelp.new.run('')
  end

end