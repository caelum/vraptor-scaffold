class AppGenerator < VraptorScaffold::Base

  TEMPLATE_ENGINES = %w( jsp ftl )
  BUILD_TOOLS = %w( ant mvn )

  argument :project_path

  class_option :template_engine, :default => "jsp", :aliases => "-e",
    :desc => "Template engine (options: #{TEMPLATE_ENGINES.join(', ')})"

  class_option :package, :default => "app", :aliases => "-p", 
    :desc => "Base package"

  class_option :build_tool, :default => "ant", :aliases => "-b", 
    :desc => "Build tool (options: #{BUILD_TOOLS.join(', ')})"

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

  def configure_build_tool
    template("pom.erb", "pom.xml") if options[:build_tool] == "mvn"
    if options[:build_tool] == "ant"
      copy_file("build.xml") 
      copy_file("ivy.xml") 
    end
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
    empty_directory Configuration::WEB_INF
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
end
