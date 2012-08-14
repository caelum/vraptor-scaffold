require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe PluginInstaller do

  it "should configure banner" do
    PluginInstaller.banner.should == "vraptor plugin install plugin_name"
  end

  it "should exit plugin installation when outside root folder" do
    File.stub(:exist?).and_return(false)
    Kernel.should_receive(:puts).with("To run 'vraptor plugin install' please go to the project root folder.")
    Kernel.should_receive(:exit)
    PluginInstaller.new("any_plugin").invoke_all
  end

end
