class Configuration
  MAIN_SRC="src/main/java"
  MAIN_RESOURCES="src/main/resources"
  TEST_SRC="src/test/java"
  TEST_RESOURCES="src/test/resources"
  WEB_APP="src/main/webapp"
  WEB_INF="#{WEB_APP}/WEB-INF"
  META_INF="#{WEB_APP}/META-INF"
  FILENAME = "#{META_INF}/vraptor-scaffold.properties"

  def self.config
    YAML.load_file File.join(Configuration::FILENAME)
  end

  def self.template_engine
    config["template_engine"]
  end

  def self.package
    config["package"]
  end

  def self.controllers_path
    File.join MAIN_SRC, package, "controllers"
  end

  def self.controllers_test_path
    File.join TEST_SRC, package, "controllers"
  end

  def self.models_path
    File.join MAIN_SRC, package, "models"
  end

  def self.models_test_path
    File.join TEST_SRC, package, "models"
  end

  def self.repositories_path
    File.join MAIN_SRC, package, "repositories"
  end

  def self.repositories_test_path
    File.join TEST_SRC, package, "repositories"
  end
end
