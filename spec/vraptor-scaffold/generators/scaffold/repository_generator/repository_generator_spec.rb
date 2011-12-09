require File.expand_path(File.dirname(__FILE__) + "/../../../../spec_helper")

describe RepositoryGenerator do
  
  it "repository template path" do
    RepositoryGenerator.new("category", build_attributes).template_path.should == "src/templates/repositories"
  end
  
  context "JPA" do
    before(:each) do
      mock_config_file
      @generator = RepositoryGenerator.new("product", build_attributes)
      @generator.build
    end
    
    after(:each) do
      FileUtils.remove_dir("src")
    end

    it "should create repository interface" do
      source = File.join File.dirname(__FILE__), "templates", "ProductRepository.java"
      destination = Configuration.main_class_path "repository", "ProductRepository.java"
      exists_and_identical?(source, destination)
    end

    it "should create repository impl" do
      source = File.join File.dirname(__FILE__), "templates", "ProductRepositoryImpl.java"
      destination = Configuration.main_class_path "repository", "ProductRepositoryImpl.java"
      exists_and_identical?(source, destination)
    end

    it "should create repository test" do
      test_class = Configuration.test_class_path "repository", "ProductRepositoryImplTest.java"
      File.exist?(test_class).should be_true
    end
  end

  context "Hibernate" do
    before(:each) do
      config = {"template_engine" => "jsp", "package" => "app", "orm" => "hibernate",
                "repositories_package" => "repository", "models_package" => "models"}
      YAML.stub!(:load_file).with(Configuration::FILENAME).and_return(config)
      @generator = RepositoryGenerator.new("client", build_attributes)
      @generator.build
    end
    
    after(:each) do
      FileUtils.remove_dir("src")
    end

    it "should create repository interface" do
      source = File.join File.dirname(__FILE__), "templates", "ClientRepository.java"
      destination = Configuration.main_class_path "repository", "ClientRepository.java"
      exists_and_identical?(source, destination)
    end

    it "should create repository impl" do
      source = File.join File.dirname(__FILE__), "templates", "ClientRepositoryImpl.java"
      destination = Configuration.main_class_path "repository", "ClientRepositoryImpl.java"
      exists_and_identical?(source, destination)
    end

    it "should create repository test" do
      test_class = Configuration.test_class_path "repository", "ClientRepositoryImplTest.java"
      File.exist?(test_class).should be_true
    end
  end
end
