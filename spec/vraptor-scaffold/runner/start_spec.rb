require "spec_helper"

describe VraptorScaffold::Runner::Start do

  before(:all) do
    @start = VraptorScaffold::Runner::Start
  end

  it "cannot run start option outside root folder" do
    File.stub!(:exist?).and_return(false)
    Kernel.should_receive(:puts).with("To run vraptor start please go to the project root folder.")
    @start.new.run nil
  end

end
