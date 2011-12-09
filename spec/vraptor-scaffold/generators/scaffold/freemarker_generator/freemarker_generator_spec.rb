require File.expand_path(File.dirname(__FILE__) + "/../../../../spec_helper")

describe FreemarkerGenerator do

  it "freemarker template path" do
    FreemarkerGenerator.new("category", build_attributes).template_path.should == "src/templates/views"
  end

  it "should append context to path" do
    FreemarkerGenerator.new("myModel", build_attributes).path.should == "${base}/myModels"
  end

  context "simple model name" do
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
      source = File.join File.dirname(__FILE__), "templates", "form.ftl"
      destination = "#{Configuration::WEB_INF}/views/product/form.ftl"
      exists_and_identical?(source, destination)
    end

    it "should create new view" do
      File.exist?("#{@views_path}/newProduct.ftl").should be_true
    end

    it "should create edit view" do
      File.exist?("#{@views_path}/edit.ftl").should be_true
    end
  end

  context "compound model name" do
    before(:all) do
      model = "OrderItem"
      @views_path = File.join Configuration::WEB_INF, "views", "orderItem"
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
      File.exist?("#{@views_path}/newOrderItem.ftl").should be_true
    end

    it "should create edit view" do
      File.exist?("#{@views_path}/edit.ftl").should be_true
    end
  end
end	
