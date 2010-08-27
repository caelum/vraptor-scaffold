require File.expand_path(File.dirname(__FILE__) + "/../../../../spec_helper")

describe RepositoryGenerator do
  
  before(:each) do
    @generator = RepositoryGenerator.new("product", build_attributes)
    @generator.build
  end
  
  after(:each) do
    FileUtils.remove_dir("src") 
  end
  
  it "should create repository interface" do
    from = File.expand_path(File.dirname(__FILE__) + "/templates/ProductRepository.java")
    to = "src/main/java/app/repositories/ProductRepository.java"
    FileUtils.compare_file(from, to).should be_true
  end
  
  it "should create repository impl" do
    from = File.expand_path(File.dirname(__FILE__) + "/templates/ProductRepositoryImpl.java")
    to = "src/main/java/app/repositories/ProductRepositoryImpl.java"
    FileUtils.compare_file(from, to).should be_true
  end
  
   it "should create repository test" do
    File.exist?("src/test/java/app/repositories/ProductRepositoryImplTest.java").should be_true
  end
end	
