require File.expand_path(File.dirname(__FILE__) + "/../../../../spec_helper")

describe ModelGenerator do
  
  before(:each) do
    @generator = ModelGenerator.new("product", build_attributes)
    @generator.build
  end
  
  after(:each) do
    FileUtils.remove_dir("src") 
  end
  
  it "should create model" do
    from = File.expand_path(File.dirname(__FILE__) + "/templates/Product.java")
    to = "src/main/java/app/models/Product.java"
    FileUtils.compare_file(from, to).should be_true
  end
  
end	
