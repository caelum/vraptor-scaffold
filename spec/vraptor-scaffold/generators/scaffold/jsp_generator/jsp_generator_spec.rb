require File.expand_path(File.dirname(__FILE__) + "/../../../../spec_helper")

describe JspGenerator do

  it "should append context to path" do
    JspGenerator.new("myModel", build_attributes).path("/edit").should == "${pageContext.request.contextPath}/myModels/edit"
  end

  context "simple model name" do
    before(:all) do
      model = "product"
      @views_path = File.join Configuration::WEB_INF, "jsp", model
      @generator = JspGenerator.new(model, build_attributes)
      @generator.build
    end

    after(:all) do
      FileUtils.remove_dir("src")
    end

    it "should create index view" do
      File.exist?("#{@views_path}/index.jsp").should be_true
    end

    it "should create show view" do
      File.exist?("#{@views_path}/show.jsp").should be_true
    end

    it "should create form view" do
      source = File.join File.dirname(__FILE__), "templates", "form.jsp"
      destination = "#{Configuration::WEB_INF}/jsp/product/form.jsp"
      exists_and_identical?(source, destination)
    end

    it "should create new view" do
      File.exist?("#{@views_path}/newProduct.jsp").should be_true
    end

    it "should create edit view" do
      File.exist?("#{@views_path}/edit.jsp").should be_true
    end
  end

  context "compound model name" do
    before(:all) do
      model = "OrderItem"
      @views_path = File.join Configuration::WEB_INF, "jsp", "orderItem"
      @generator = JspGenerator.new(model, build_attributes)
      @generator.build
    end

    after(:all) do
      FileUtils.remove_dir("src")
    end

    it "should create index view" do
      File.exist?("#{@views_path}/index.jsp").should be_true
    end

    it "should create show view" do
      File.exist?("#{@views_path}/show.jsp").should be_true
    end

    it "should create form view" do
      File.exist?("#{@views_path}/form.jsp").should be_true
    end

    it "should create new view" do
      File.exist?("#{@views_path}/newOrderItem.jsp").should be_true
    end

    it "should create edit view" do
      File.exist?("#{@views_path}/edit.jsp").should be_true
    end
  end

end
