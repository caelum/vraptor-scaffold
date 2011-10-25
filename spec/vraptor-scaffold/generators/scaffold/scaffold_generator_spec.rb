require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe ScaffoldGenerator do

  before(:each) do
    @model = "product"
    args = [@model, {"name" => "string", "value" => "double"}]
    @generator = ScaffoldGenerator.new(args)
    @attributes = @generator.generated_attributes
  end

  context "generated attributes" do
    it "should generate name attribute" do
      att = @attributes.first
      att.name.should == "name"
      att.type.should == "string"
    end

    it "should generate value attribute" do
      att = @attributes.last
      att.name.should == "value"
      att.type.should == "double"
    end
  end

  it "should call model generator" do
    config = {}
    YAML.stub!(:load_file).with(Configuration::FILENAME).and_return(config)
    @model_generator = mock(ModelGenerator)
    ModelGenerator.stub!(:new).with(@model, @attributes).and_return(@model_generator)
    @model_generator.should_receive(:build)
    @generator.model_generator
  end

  it "should call objectify model generator" do
    config = {"orm" => "objectify"}
    YAML.stub!(:load_file).with(Configuration::FILENAME).and_return(config)
    @model_generator = mock(ObjectifyModelGenerator)
    ObjectifyModelGenerator.stub!(:new).with(@model, @attributes).and_return(@model_generator)
    @model_generator.should_receive(:build)
    @generator.model_generator
  end

  it "should call controller generator" do
    @controller_generator = mock(ControllerGenerator)
    ControllerGenerator.stub!(:new).with(@model, @attributes).and_return(@controller_generator)
    @controller_generator.should_receive(:build)
    @generator.controller_generator
  end

  it "should call freemarker generator" do
    Configuration.stub!(:template_engine).and_return("ftl")
    @freemarker_generator = mock(FreemarkerGenerator)
    FreemarkerGenerator.stub!(:new).with(@model, @attributes).and_return(@freemarker_generator)
    @freemarker_generator.should_receive(:build)
    @generator.template_engine_generator
  end

  it "should call jsp generator" do
    Configuration.stub!(:template_engine).and_return("jsp")
    @jsp_generator = mock(JspGenerator)
    JspGenerator.stub!(:new).with(@model, @attributes).and_return(@jsp_generator)
    @jsp_generator.should_receive(:build)
    @generator.template_engine_generator
  end

  it "should call repository generator" do
    @repository_generator = mock(RepositoryGenerator)
    RepositoryGenerator.stub!(:new).with(@model, @attributes).and_return(@repository_generator)
    @repository_generator.should_receive(:build)
    @generator.repository_generator
  end

  it "should configure banner" do
    ScaffoldGenerator.banner.should == "vraptor scaffold MODEL [field:type field:type]"
  end
end	
