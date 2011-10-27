require File.expand_path(File.dirname(__FILE__) + "/../../../../spec_helper")

describe ObjectifyRepositoryGenerator do

  after(:each) do
    FileUtils.remove_dir('src')
  end

  context "Objectify" do
    before(:each) do
      mock_config_file
      @generator = ObjectifyRepositoryGenerator.new("product", build_attributes)
      @generator.build
    end

    it "should create repository interface" do
      source = File.join File.dirname(__FILE__), "templates", "Objectify_ProductRepository.java"
      destination = Configuration.main_class_path "repository", "ProductRepository.java"
      exists_and_identical?(source, destination)
    end

    it "should create repository impl" do
      source = File.join File.dirname(__FILE__), "templates", "Objectify_ProductRepositoryImpl.java"
      destination = Configuration.main_class_path "repository", "ProductRepositoryImpl.java"
      exists_and_identical?(source, destination)
    end

    it "should create repository test" do
      test_class = Configuration.test_class_path "repository", "ProductRepositoryImplTest.java"
      File.exist?(test_class).should be_true
    end
  end
end
