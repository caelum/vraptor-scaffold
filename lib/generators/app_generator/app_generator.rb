class AppGenerator < VraptorScaffold::Base

  argument :project_path
  class_option :template_engine, :default => :jsp

  def self.source_root
    File.join(File.dirname(__FILE__), "templates")
  end

  def initialize(args, opts=[])
    super([args], opts)
    self.destination_root=(project_path)
    @project_name = @project_path.split("/").last
  end

  def create_root_folder
    empty_directory "."
  end

  def create_pom
    template("pom.erb", "pom.xml")
  end

  def create_main_java
    empty_directory Configuration::MAIN_SRC
    directory("src", Configuration::MAIN_SRC + "/app")
  end

  def create_main_resources
    directory("resources", Configuration::MAIN_RESOURCES)
  end

  def create_webapp
    webapp = Configuration::WEB_APP
    directory("webapp", webapp)
    inside webapp do
      create_decorators
      create_macros
    end
  end

  def create_test
    empty_directory Configuration::TEST_SRC
    directory("src-test", Configuration::TEST_SRC + "/app")
    directory("resources-test", Configuration::TEST_RESOURCES)
  end

  private
  def create_macros
    macros = empty_directory "macros"
    inside macros do
      template_from_root("macros/html.ftl", "#{macros}/html.ftl")
    end
  end

  def create_decorators
    decorators = empty_directory "decorators"
    inside decorators do
      template_from_root("main.ftl", "#{decorators}/main.ftl")
    end
  end

  def template_from_root(template, to)
    in_root do
      template(template, to)
    end
  end
end
