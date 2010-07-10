require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe ScaffoldGenerator do
  
  before(:each) do
    @args = ["product", "name:string", "value:double"]
  end
  
  context "outside project root" do
     before(:each) do
      File.stub!(:exist?).with("pom.xml").and_return(false)
     end
    
    it "should exit without run generators" do
      Kernel.should_receive(:exit)
      ScaffoldGenerator.new(@args)
    end
  end
  
  context "in project root" do
    
    before(:each) do
      File.stub!(:exist?).and_return(true)
      @generator = ScaffoldGenerator.new(@args)
    
      @model_generator = mock(ModelGenerator)
      ModelGenerator.stub!(:new).with(@generator.model, @generator.attributes).and_return(@model_generator)
    
      @controller_generator = mock(ControllerGenerator)
      ControllerGenerator.stub!(:new).with(@generator.model, @generator.attributes).and_return(@controller_generator)
      
      @freemarker_generator = mock(FreemarkerGenerator)
      FreemarkerGenerator.stub!(:new).with(@generator.model, @generator.attributes).and_return(@freemarker_generator)
    
    @model_generator.stub!(:build)
    @controller_generator.stub!(:build)
    @freemarker_generator.stub!(:build)
  end
    
    it "should call model generator" do
      @model_generator.should_receive(:build)
      @generator.build
    end
    
    it "should call controller generator" do
      @controller_generator.should_receive(:build)
      @generator.build
    end
    
   it "should call freemarker generator" do
      @freemarker_generator.should_receive(:build)
      @generator.build
    end
  end
end	
