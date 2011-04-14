require File.expand_path(File.dirname(__FILE__) + "/../../../../spec_helper")

describe ModelGenerator do

  before(:each) do
    mock_config_file
    @generator = ModelGenerator.new("product", build_attributes)
    @generator.build
  end

  after(:each) do
    FileUtils.remove_dir("src") 
  end

  it "should create model" do
    source = File.join File.dirname(__FILE__), "templates", "Product.java"
    destination = Configuration.main_class_path "models", "Product.java"
    exists_and_identical?(source, destination)
  end

  it "should create model test" do
    test_class = Configuration.test_class_path "models", "ProductTest.java"
    File.exist?(test_class).should be_true 
  end
end	
