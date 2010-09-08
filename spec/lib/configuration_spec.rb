require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe Configuration do

  it "should configure main source" do
    Configuration::MAIN_SRC.should == "src/main/java"
  end

  it "should configure main resources" do
    Configuration::MAIN_RESOURCES.should == "src/main/resources"
  end

  it "should configure test source" do
    Configuration::TEST_SRC.should == "src/test/java"
  end

  it "should configure test resources" do
    Configuration::TEST_RESOURCES.should == "src/test/resources"
  end

  it "should configure webapp" do
    Configuration::WEB_APP.should == "src/main/webapp"
  end

  it "should configure web-inf" do
    Configuration::WEB_INF.should == "#{Configuration::WEB_APP}/WEB-INF"
  end

  it "should configure meta-inf" do
    Configuration::META_INF.should == "#{Configuration::WEB_APP}/META-INF"
  end

  it "should configure properties name" do
    Configuration::FILENAME.should == "#{Configuration::META_INF}/vraptor-scaffold.properties"
  end

  context "load config file" do
    before(:each) do
      config = {"template_engine" => "jsp", "package" => "br.com.caelum"}
      YAML.stub!(:load_file).with(Configuration::FILENAME).and_return(config)
    end

    it "should know template engine" do
      Configuration.template_engine.should == "jsp"  
    end

    it "should know base package" do
      Configuration.package.should == "br.com.caelum"  
    end

    it "should build main class path with base package" do
      Configuration.main_class_path("models", "Product.java").should == "src/main/java/br/com/caelum/models/Product.java"
    end

    it "should build test class path with base package" do
      Configuration.test_class_path("models", "Product.java").should == "src/test/java/br/com/caelum/models/Product.java"
    end

  end
end
