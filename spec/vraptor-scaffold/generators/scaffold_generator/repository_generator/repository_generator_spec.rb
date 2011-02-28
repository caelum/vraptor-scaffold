require File.expand_path(File.dirname(__FILE__) + "/../../../../spec_helper")

describe RepositoryGenerator do

  before(:each) do
    mock_config_file
    @generator = RepositoryGenerator.new("product", build_attributes)
    @generator.build
  end

  after(:each) do
    FileUtils.remove_dir("src") 
  end
  
  it "should create repository interface" do
    source = File.join File.dirname(__FILE__), "templates", "ProductRepository.java"
    destination = Configuration.main_class_path "repositories", "ProductRepository.java"
    exists_and_identical?(source, destination)
  end

  it "should create repository impl" do
    source = File.join File.dirname(__FILE__), "templates", "ProductRepositoryImpl.java"
    destination = Configuration.main_class_path "repositories", "ProductRepositoryImpl.java"
    exists_and_identical?(source, destination)
  end

  it "should create repository test" do
    test_class = Configuration.test_class_path "repositories", "ProductRepositoryImplTest.java" 
    File.exist?(test_class).should be_true
  end
end	
