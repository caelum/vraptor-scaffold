require File.expand_path(File.dirname(__FILE__) + "/../../../../spec_helper")

describe GaeDependencies do

  before(:each) do
    others_dependency = mock(Dependency)
    others_dependency.stub!(:exclusions).and_return([])
    Dependency.stub!(:new).and_return(others_dependency)
    @dependency = mock(Dependency)
  end

  context "compile scope" do
    it "should include freemarker dependency when template is freemarker" do
      options = {:template_engine => "ftl"}
      Dependency.stub!(:new).with("org.freemarker", "freemarker", "2.3.18").and_return(@dependency)
      GaeDependencies.new(options).compile_scope.include?(@dependency).should be_true
    end
  end

end
