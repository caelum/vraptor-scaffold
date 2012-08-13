require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe PluginInstaller do

  it "should configure banner" do
    PluginInstaller.banner.should == "vraptor plugin install plugin_name"
  end

end
