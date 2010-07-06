require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe ScaffoldGenerator do
  
  before(:each) do
    @generator = ScaffoldGenerator.new
    @generator.build(["product", "name:string", "value:double"])
  end
  
  after(:each) do
    FileUtils.remove_dir("src") 
  end
  
  it "should create index view" do
    File.exist?("src/main/webapp/WEB-INF/freemarker/product/index.ftl").should be_true 
  end
  
  it "should create show view" do
    File.exist?("src/main/webapp/WEB-INF/freemarker/product/show.ftl").should be_true 
  end
  
  it "should create new view" do
    File.exist?("src/main/webapp/WEB-INF/freemarker/product/new.ftl").should be_true 
  end
  
  it "should create edit view" do
    File.exist?("src/main/webapp/WEB-INF/freemarker/product/edit.ftl").should be_true 
  end
end	
