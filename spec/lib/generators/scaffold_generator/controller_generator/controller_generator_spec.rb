require File.expand_path(File.dirname(__FILE__) + "/../../../../spec_helper")

describe ControllerGenerator do
  
  before(:each) do
    @generator = ControllerGenerator.new(["product", "name:string", "value:double"])
    @generator.build
  end
  
  after(:each) do
    FileUtils.remove_dir("src") 
  end
  
  it "should create controller" do
    from = File.expand_path(File.dirname(__FILE__) + "/templates/ProductController.java")
    to = "src/main/java/app/controllers/ProductController.java"
    FileUtils.compare_file(from, to).should be_true
  end
  
end	
