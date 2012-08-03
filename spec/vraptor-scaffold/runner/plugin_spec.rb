require "spec_helper"

describe VraptorScaffold::Runner::Plugin do

  before(:all) do
    @help = VraptorScaffold::Runner::Help
    @plugin_runner = VraptorScaffold::Runner::Plugin
  end

  context "help command" do
    before :each do
      @help.stub!(:help).with("--help").and_return true
      PluginGenerator.should_receive(:start).with(["-h"])
    end

    it "should ptin when options --help" do
      @plugin_runner.new.run(["--help"])
    end
  end

  context "plugins list" do
    it "should be downloaded if not exists" do
      File.stub(:exist?).with(".vraptor-contrib").and_return(false)
      PluginListFetcher.should_receive(:fetch)
      @plugin_runner.new.run(["list"])
    end

    it "should be shown when exists" do
      File.stub(:exist?).with(".vraptor-contrib").and_return(true)
      PluginListFetcher.should_not_receive(:fetch)
      @plugin_runner.new.run(["list"])
    end
  end

  context "plugin generator" do
    before(:each) do
      @generator = mock(PluginGenerator)
      @name = "simplemail"
      @args = [@name, "-v=1.0.0"]
    end

    it "should invoke plugin tasks" do
      File.stub!(:exist?).and_return(true)
      PluginGenerator.stub!(:new).with(@name, @args).and_return(@generator)
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
