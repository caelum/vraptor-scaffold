require "spec_helper"

describe VraptorScaffold::Runner::Start do

  before(:all) do
    @start = VraptorScaffold::Runner::Start
  end

  it "should execute shell command lines normally" do
    File.stub!(:exist?).and_return(true)
    Configuration.stub!(:orm).and_return("objectify")
    ENV['APPENGINE_SDK_HOME'] = "any_local" unless ENV['APPENGINE_SDK_HOME']
    Kernel.should_receive(:system).twice
    @start.new.run nil
  end

  context "validate the startup of a gae app" do

    it "cannot run start option outside root folder" do
      File.stub!(:exist?).and_return(false)
      Kernel.should_receive(:puts).with("To run vraptor start please go to the project root folder.")
      lambda { @start.new.run nil }.should raise_error(SystemExit)
    end

    it "cannot start a app if objectify orm isn't used (gae app)" do
      File.stub!(:exist?).and_return(true)
      Configuration.stub!(:orm).and_return("hibernate")
      Kernel.should_receive(:puts).with("vraptor start command is available only for gae apps.")
      lambda { @start.new.run nil }.should raise_error(SystemExit)
    end

    context "without a APPENGINE_SDK_HOME" do

      before(:all) do
        @appengine_sdk_home = ENV['APPENGINE_SDK_HOME']
        ENV.delete 'APPENGINE_SDK_HOME'
      end

      after :all do
        ENV['APPENGINE_SDK_HOME'] = @appengine_sdk_home
      end

      it "should not run vraptor start" do
        File.stub!(:exist?).and_return(true)
        Configuration.stub!(:orm).and_return("objectify")
        Kernel.should_receive(:puts).with("To run vraptor start, configure the env var APPENGINE_SDK_HOME.")
        lambda { @start.new.run nil }.should raise_error(SystemExit)
      end
    end
  end
end
