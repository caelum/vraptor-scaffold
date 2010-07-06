require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe ScaffoldGenerator do
  
  before(:each) do
    @args = ["product", "name:string", "value:double"]
    @generator = ScaffoldGenerator.new
    @model_generator = mock(ModelGenerator)
    ModelGenerator.stub!(:new).with(@args).and_return(@model_generator)
    @controller_generator = mock(ControllerGenerator)
    ControllerGenerator.stub!(:new).with(@args).and_return(@controller_generator)
    @freemarker_generator = mock(FreemarkerGenerator)
    FreemarkerGenerator.stub!(:new).with(@args).and_return(@freemarker_generator)
    @model_generator.stub!(:build)
    @controller_generator.stub!(:build)
    @freemarker_generator.stub!(:build)
  end
  
  context "build scaffold" do
    it "should call model generator" do
      @model_generator.should_receive(:build)
      @generator.build(@args)
    end
    
    it "should call controller generator" do
      @controller_generator.should_receive(:build)
      @generator.build(@args)
    end
    
    it "should call freemarker generator" do
      @freemarker_generator.should_receive(:build)
      @generator.build(@args)
    end
  end
end	
