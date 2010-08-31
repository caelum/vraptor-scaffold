require File.expand_path(File.dirname(__FILE__) + "/../../../../spec_helper")

describe JspGenerator do
  before(:each) do
    @views_path = "#{Configuration::WEB_INF}/jsp"
    @generator = JspGenerator.new("product", build_attributes)
    @generator.build
  end

  after(:each) do
    FileUtils.remove_dir("src") 
  end

  it "should create index view" do
    File.exist?("#{@views_path}/product/index.jsp").should be_true 
  end

  it "should create show view" do
    File.exist?("#{@views_path}/product/show.jsp").should be_true 
  end

  it "should create form view" do
    File.exist?("#{@views_path}/product/form.jsp").should be_true 
  end

  it "should create new view" do
    File.exist?("#{@views_path}/product/newProduct.jsp").should be_true 
  end

  it "should create edit view" do
    File.exist?("#{@views_path}/product/edit.jsp").should be_true 
  end
end	
