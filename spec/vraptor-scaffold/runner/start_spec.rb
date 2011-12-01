require "spec_helper"

describe VraptorScaffold::Runner::Start do

  before(:all) do
    @start = VraptorScaffold::Runner::Start
  end

  it "cannot run start option outside root folder" do
    File.stub!(:exist?).and_return(false)
    Kernel.should_receive(:puts).with("To run vraptor start please go to the project root folder.")
    lambda { @start.new.run nil }.should raise_error(SystemExit)
    
  end

  context "starting a gae app" do

    it "cannot start a app if objectify orm isn't used (gae app)" do
      File.stub!(:exist?).and_return(true)
      Configuration.stub!(:orm).and_return("hibernate")
      Kernel.should_receive(:puts).with("vraptor start command is available only for gae apps")
      lambda { @start.new.run nil }.should raise_error(SystemExit)
    end

  end
end
