require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe VraptorScaffold::Main do
  
  context "new application" do
    before(:each) do
      @project_name = "vraptor-scaffold"
      @generator = mock(AppGenerator)
      AppGenerator.stub!(:new).and_return(@generator)
      @args = ["new", @project_name]
    end 
    
    it "should call app generator when typed new" do
      @generator.should_receive(:build).with(@project_name)
      VraptorScaffold::Main.execute(@args)
    end
    
    it "cannot call app generator when not typed new" do
      @args.delete("new")
      @generator.should_not_receive(:build)
     	VraptorScaffold::Main.execute(@args)
    end
  end
end
