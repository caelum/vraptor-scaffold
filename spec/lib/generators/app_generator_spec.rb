require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")

describe AppGenerator do
  
  context "build new application" do
    before(:each) do
      @project_name = "vraptor-scaffold"
      @generator = AppGenerator.new
    end 
    
    it "should create directory with project name" do
      @generator.should_receive(:empty_directory).with(@project_name)
      @generator.build(@project_name)
    end
  end
end
