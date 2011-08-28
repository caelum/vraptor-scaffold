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
      @args = ["simplemail", "-v=1.0.0"]
    end

    it "should invoke plugin tasks" do
      File.stub!(:exist?).and_return(true)
      PluginGenerator.stub!(:new).with(@args).and_return(@generator)
      @generator.should_receive(:invoke_all)
      @plugin_runner.new.run(@args)
    end

    it "cannot invoke plugin generator outsite root folder" do
      File.stub!(:exist?).and_return(false)
      PluginGenerator.should_not_receive(:new)
      @plugin_runner.new.run(@args)
    end
  end
end