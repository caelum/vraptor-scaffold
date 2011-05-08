require File.expand_path(File.dirname(__FILE__) + "/../../../../spec_helper")

describe FreemarkerGenerator do

  before(:all) do
    model = "product"
    @views_path = File.join Configuration::WEB_INF, "views", model
    @generator = FreemarkerGenerator.new(model, build_attributes)
    @generator.build
  end

  after(:all) do
    FileUtils.remove_dir("src") 
  end

  it "should create index view" do
    File.exist?("#{@views_path}/index.ftl").should be_true 
  end

  it "should create show view" do
    File.exist?("#{@views_path}/show.ftl").should be_true 
  end

  it "should create form view" do
    File.exist?("#{@views_path}/form.ftl").should be_true 
  end

  it "should create new view" do
    File.exist?("#{@views_path}/newProduct.ftl").should be_true 
  end

  it "should create edit view" do
    File.exist?("#{@views_path}/edit.ftl").should be_true 
  end

end	
