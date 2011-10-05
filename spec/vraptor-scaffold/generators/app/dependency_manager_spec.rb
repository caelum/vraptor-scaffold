require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe DependencyManager do

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
      DependencyManager.new(options).compile_scope.include?(@dependency).should be_true
    end

    context "dependencies for a gae app" do
      it "should include gae dependencies when gae project option is selected" do
        options = {:gae => true}
        Dependency.stub!(:new).with("com.googlecode.objectify", "objectify", "2.2.3").and_return(@dependency)
        DependencyManager.new(options).compile_scope.include?(@dependency).should be_true
      end

      it "should not have hibernate persistence dependencies when gae project option is selected" do
        options = {:gae => true}
        Dependency.stub!(:new).with("org.hibernate", "hibernate-entitymanager", "3.6.7.Final").and_return(@dependency)
        DependencyManager.new(options).compile_scope.include?(@dependency).should be_false
      end
    end
  end

end
