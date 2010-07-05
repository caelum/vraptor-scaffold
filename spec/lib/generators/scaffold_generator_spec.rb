require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")

describe ScaffoldGenerator do
  
  before(:each) do
    @generator = ScaffoldGenerator.new
    @generator.build(["product", "name:string", "value:double"])
  end
  
  after(:each) do
    FileUtils.remove_dir("src/main/java/app") 
  end
  
  it "should create controller" do
    from = File.expand_path(File.dirname(__FILE__) + "/templates/scaffold/ProductController.java")
    to = "src/main/java/app/controllers/ProductController.java"
    FileUtils.compare_file(from, to).should be_true
  end
  
  it "should create model" do
    from = File.expand_path(File.dirname(__FILE__) + "/templates/scaffold/Product.java")
    to = "src/main/java/app/models/Product.java"
    FileUtils.compare_file(from, to).should be_true
  end
  
  xit "should create views" do
  end
end	
