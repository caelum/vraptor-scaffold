class Configuration
  MAIN_SRC = "src/main/java"
  MAIN_RESOURCES = "src/main/resources"
  TEST_SRC = "src/test/java"
  TEST_RESOURCES = "src/test/resources"
  WEB_APP = "src/main/webapp"
  WEB_INF = "#{WEB_APP}/WEB-INF"
  META_INF = "#{WEB_APP}/META-INF"
  FILENAME = "#{META_INF}/vraptor-scaffold.properties"

  def self.config
    YAML.load_file FILENAME
  end

  def self.template_engine
    config["template_engine"]
  end

  def self.package
    config["package"]
  end

  def self.models_package
    config["models_package"]
  end

  def self.controllers_package
    config["controllers_package"]
  end

  def self.full_models_package
    "#{package}.#{models_package}"
  end

  def self.orm
    config["orm"]
  end

  def self.hibernate?
    orm.eql? "hibernate"
  end

  def self.main_class_path *path
    File.join MAIN_SRC, package.gsub(".", File::Separator), path
  end

  def self.test_class_path *path
    File.join TEST_SRC, package.gsub(".", File::Separator), path
  end

end
