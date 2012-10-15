require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe ContribInstaller do

  it "should configure banner" do
    ContribInstaller.banner.should == "vraptor contrib install contrib_name"
  end

  it "should exit contrib installation when outside root folder" do
    File.stub(:exist?).and_return(false)
    Kernel.should_receive(:puts).with("To run 'vraptor contrib install' please go to the project root folder.")
    Kernel.should_receive(:exit)

    ContribInstaller.new("any_contrib").invoke_all
  end

end
