require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe Dependency do
  
  it "should has exclusions" do
    dependency = Dependency.new("org.vraptor", "vraptor3", "3.0.0", [Dependency.new("org.vraptor2", "2.0.0")])
    dependency.has_exclusions?.should be_true
  end
  
  it "cannot has exclusions" do
    dependency = Dependency.new("org.vraptor", "vraptor3", "3.0.0")
    dependency.has_exclusions?.should be_false
  end
end