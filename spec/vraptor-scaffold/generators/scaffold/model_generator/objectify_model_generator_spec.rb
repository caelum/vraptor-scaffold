require File.expand_path(File.dirname(__FILE__) + "/../../../../spec_helper")

describe ObjectifyModelGenerator do

  context "objectify" do
    before(:all) do
      AppGenerator.new("src", ["-o=objectify", "--gae"]).invoke_all
      FileUtils.chdir("src")
      @generator = ObjectifyModelGenerator.new("product", build_attributes)
      @generator.build
      FileUtils.chdir("..")
      @project_path = "src"
    end

    before(:each) do 
      mock_objectify_config_file
    end

    after(:all) do
      FileUtils.remove_dir "src"
    end

    it "should create model" do
      source = File.join File.dirname(__FILE__), "templates", "Objectify_Product.java"
      destination = @project_path + File::Separator + Configuration.main_class_path("models", "Product.java")
      exists_and_identical?(source, destination)
    end

    it "should create model test" do
      test_class = @project_path + File::Separator + Configuration.test_class_path("models", "ProductTest.java")
      File.exist?(test_class).should be_true
    end

    it "should map model in objetify factory" do
      source = File.join File.dirname(__FILE__), "templates", "ObjectifyFactory.java"
      destination = File.join "src", Configuration::MAIN_SRC, "app", "infra", "ObjectifyFactory.java"
      exists_and_identical?(source, destination)
    end
  end
end
