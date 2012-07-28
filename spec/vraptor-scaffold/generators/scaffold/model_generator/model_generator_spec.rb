require File.expand_path(File.dirname(__FILE__) + "/../../../../spec_helper")

describe ModelGenerator do

  it "model template path" do
    ModelGenerator.new("category", build_attributes).template_path.should == "src/templates/models"
  end

  context "jpa" do
    before(:each) do
      mock_config_file
      @generator = ModelGenerator.new("product", build_attributes)
      @generator.build
    end

    after(:each) do
      FileUtils.remove_dir("src")
    end

    it "should create model" do
      source = File.join File.dirname(__FILE__), "templates", "Product.java"
      destination = Configuration.main_class_path "model", "Product.java"
      exists_and_identical?(source, destination)
    end

    it "should create model test" do
      test_class = Configuration.test_class_path "model", "ProductTest.java"
      File.exist?(test_class).should be_true
    end
  end

  context "hibernate" do
    before(:each) do
      config = {"package" => "app", "orm" => "hibernate", "models_package" => "model"}
      YAML.stub!(:load_file).with(Configuration::FILENAME).and_return(config)
      AppGenerator.new("src", ["-o=hibernate", "--skip_jquery"]).configure_orm
      FileUtils.chdir("src")
      @generator = ModelGenerator.new("product", build_attributes)
      @generator.build
      FileUtils.chdir("..")
    end

    after(:each) do
      FileUtils.remove_dir("src")
    end

    it "should map entity in hibernate.cfg.xml when orm is hibernate" do
      source = File.join File.dirname(__FILE__), "templates", "hibernate.cfg.xml"
      destination = File.join "src", Configuration::MAIN_RESOURCES, "hibernate.cfg.xml"
      exists_and_identical?(source, destination)
    end
  end

end
