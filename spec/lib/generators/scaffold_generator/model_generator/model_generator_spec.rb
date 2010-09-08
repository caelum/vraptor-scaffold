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
    from = File.expand_path(File.dirname(__FILE__) + "/templates/Product.java")
    to = "#{Configuration::MAIN_SRC}/app/models/Product.java"
    FileUtils.compare_file(from, to).should be_true
  end

  it "should create model test" do
    File.exist?("#{Configuration::TEST_SRC}/app/models/ProductTest.java").should be_true 
  end
end	
