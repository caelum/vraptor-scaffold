require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe DependencyManager do
  context "compile scope" do
    it "should include freemarker dependency when template is freemarker" do
      options = {:template_engine => "ftl"}
      dependency = mock(Dependency)
      Dependency.stub!(:new).and_return(mock(Dependency))
      Dependency.stub!(:new).with("org.freemarker", "freemarker", "2.3.16").and_return(dependency)
      DependencyManager.new(options).compile_scope.last.should == dependency
    end
  end
end