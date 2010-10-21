class AppGenerator < VraptorScaffold::Base

  TEMPLATE_ENGINES = %w( jsp ftl )
  BUILD_TOOLS = %w( ant mvn gradle )
  IVY_JAR = "ivy-2.2.0.jar"
  SPRING_VERSIONS = %w( 2.5 3.0 )

  argument :project_path

  class_option :template_engine, :default => "jsp", :aliases => "-e",
    :desc => "Template engine (options: #{TEMPLATE_ENGINES.join(', ')})"

  class_option :package, :default => "app", :aliases => "-p", 
    :desc => "Base package"

  class_option :build_tool, :default => "ant", :aliases => "-b", 
    :desc => "Build tools (options: #{BUILD_TOOLS.join(', ')})"
  
  class_option :skip_eclipse, :type => :boolean, :aliases => "-E",
    :desc => "Skip Eclipse files"

  class_option :spring_version, :default => "2.5", :aliases => "-S",
    :desc => "Spring version (options: #{SPRING_VERSIONS})"

  def self.source_root
    File.join File.dirname(__FILE__), "templates"
  end

  def self.banner
    "vraptor new #{self.arguments.map(&:usage).join(' ')} [options]"
  end

  def initialize(args, opts=[])
    super([args], opts)
    self.destination_root=(project_path)
    @project_name = project_path.split("/").last
  end

  def create_root_folder
    empty_directory "."
  end

  def configure_maven
    @spring_version = options[:spring_version]
    template("pom.erb", "pom.xml") if options[:build_tool] == "mvn"
  end

  def configure_ant
    if options[:build_tool] == "ant"
      create_eclipse_files unless options[:skip_eclipse]
      copy_file("build.xml")
      template("build.properties.erb", "build.properties") 
      template("ivy.erb", "ivy.xml") 
      copy_file(IVY_JAR)
    end
  end

  def configure_gradle
    template("build.gradle.erb", "build.gradle") if options[:build_tool] == "gradle"
  end

  def create_main_java
    empty_directory Configuration::MAIN_SRC
    directory("src", File.join(Configuration::MAIN_SRC, options[:package].gsub(".", File::Separator)))
  end

  def create_main_resources
    directory("resources", Configuration::MAIN_RESOURCES)
  end

  def create_webapp
    directory("webapp", Configuration::WEB_APP)
  end

  def configure_template_engine
    template("vraptor-scaffold.erb", Configuration::FILENAME)
    templates = {"jsp" => JspTemplateEngine, "ftl" => FreemarkerTemplateEngine}
    templates[options[:template_engine]].new(project_path).configure
  end

  def create_test
    empty_directory Configuration::TEST_SRC
    directory("src-test", File.join(Configuration::TEST_SRC, options[:package].gsub(".", File::Separator)))
    directory("resources-test", Configuration::TEST_RESOURCES)
  end

  private
  def create_eclipse_files
    template("eclipse/project.erb", ".project")
    template("eclipse/classpath.erb", ".classpath")
    directory("eclipse/settings", ".settings")
  end
end
