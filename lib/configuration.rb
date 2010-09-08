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

  def self.main_class_path *path
    File.join MAIN_SRC, package, path
  end  

  def self.test_class_path *path
    File.join TEST_SRC, package, path
  end 

end
