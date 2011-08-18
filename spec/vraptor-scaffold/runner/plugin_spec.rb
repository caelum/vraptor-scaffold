require "spec_helper"

describe VraptorScaffold::Runner::Plugin do

  before(:all) do
    @help = VraptorScaffold::Runner::Help
    @plugin_runner = VraptorScaffold::Runner::Plugin
  end

  it "should print help command" do
    @help.stub!(:help).with("--help").and_return true
    PluginGenerator.should_receive(:start).with(["-h"])
    @plugin_runner.new.run(["--help"])
  end

  context "plugin generator" do
    before(:each) do
      @generator = mock(PluginGenerator)
      @args = ["simplemail"]
    end

    it "cannot invoke plugin generator outsite root folder" do
      File.stub!(:exist?).and_return(false)
      PluginGenerator.should_not_receive(:new)
      @plugin_runner.new.run(@args)
    end
  end
end