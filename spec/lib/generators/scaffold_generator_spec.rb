require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")

describe ScaffoldGenerator do
  
  xit "should create controller" do
  end
  
  it "should create model" do
    @generator = ScaffoldGenerator.new
    @generator.build(["product", "name:string"])
    from = File.expand_path(File.dirname(__FILE__) + "/templates/scaffold/Product.java")
    to = "src/main/java/app/models/Product.java"
    FileUtils.compare_file(from, to).should be_true
    FileUtils.remove_dir("src/main/java/app") 
  end
  
  xit "should create views" do
  end
end	
