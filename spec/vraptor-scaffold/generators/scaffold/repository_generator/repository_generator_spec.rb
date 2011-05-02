require File.expand_path(File.dirname(__FILE__) + "/../../../../spec_helper")

describe RepositoryGenerator do

  after(:each) do
    FileUtils.remove_dir("src")
  end

  context "JPA" do
    before(:each) do
      mock_config_file
      @generator = RepositoryGenerator.new("product", build_attributes)
      @generator.build
    end

    it "should create repository interface" do
      source = File.join File.dirname(__FILE__), "templates", "ProductRepository.java"
      destination = Configuration.main_class_path "repositories", "ProductRepository.java"
      exists_and_identical?(source, destination)
    end

    it "should create repository impl" do
      source = File.join File.dirname(__FILE__), "templates", "ProductRepositoryImpl.java"
      destination = Configuration.main_class_path "repositories", "ProductRepositoryImpl.java"
      exists_and_identical?(source, destination)
    end

    it "should create repository test" do
      test_class = Configuration.test_class_path "repositories", "ProductRepositoryImplTest.java"
      File.exist?(test_class).should be_true
    end
  end

  context "Hibernate" do
    before(:each) do
      config = {"template_engine" => "jsp", "package" => "app", "orm" => "hibernate", "repositories_package" => "repository"}
      YAML.stub!(:load_file).with(Configuration::FILENAME).and_return(config)
      @generator = RepositoryGenerator.new("client", build_attributes)
      @generator.build
    end

    it "should create repository interface" do
      source = File.join File.dirname(__FILE__), "templates", "ClientRepository.java"
      destination = Configuration.main_class_path "repositories", "ClientRepository.java"
      exists_and_identical?(source, destination)
    end

    it "should create repository impl" do
      source = File.join File.dirname(__FILE__), "templates", "ClientRepositoryImpl.java"
      destination = Configuration.main_class_path "repositories", "ClientRepositoryImpl.java"
      exists_and_identical?(source, destination)
    end

    it "should create repository test" do
      test_class = Configuration.test_class_path "repositories", "ClientRepositoryImplTest.java"
      File.exist?(test_class).should be_true
    end
  end
end
