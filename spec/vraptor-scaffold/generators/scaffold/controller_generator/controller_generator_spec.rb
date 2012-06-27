require File.expand_path(File.dirname(__FILE__) + "/../../../../spec_helper")

describe ControllerGenerator do

  it "paths to simple model name" do
    ControllerGenerator.new("product", build_attributes).path.should == "/products"
  end

  it "paths to compound model name" do
    ControllerGenerator.new("orderItem", build_attributes).path.should == "/orderItems"
  end
  
  it "controller template path" do
    ControllerGenerator.new("category", build_attributes).template_path.should == "src/templates/controllers"
  end

  describe "generating from a lowercased name" do
    before(:each) do
      mock_config_file
      @generator = ControllerGenerator.new("product", build_attributes)
      @generator.build
    end

    after(:each) do
      FileUtils.remove_dir("src")
    end

    it "should create controller" do
      source = File.join File.dirname(__FILE__), "templates", "ProductController.java"
      destination = Configuration.main_class_path "controller", "ProductController.java"
      exists_and_identical?(source, destination)
    end

    it "should create controller test" do
      test_class = Configuration.test_class_path "controller", "ProductControllerTest.java"
      File.exist?(test_class).should be_true
    end
  end

  describe "generating from an uppercased name" do
    before(:each) do
      mock_config_file
      @generator = ControllerGenerator.new("Product", build_attributes)
      @generator.build
    end

    after(:each) do
      FileUtils.remove_dir("src")
    end

    it "should create controller" do
      source = File.join File.dirname(__FILE__), "templates", "ProductController.java"
      destination = Configuration.main_class_path "controller", "ProductController.java"
      exists_and_identical?(source, destination)
    end

    it "should create controller test" do
      test_class = Configuration.test_class_path "controller", "ProductControllerTest.java"
      File.exist?(test_class).should be_true
    end
  end
end
