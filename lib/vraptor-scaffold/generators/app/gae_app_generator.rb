class GaeAppGenerator < VraptorScaffold::Base

  argument :project_path

  class_option :package, :default => "app", :aliases => "-p",
               :desc => "Define base package"

  class_option :models_package, :aliases => "-m", :default => "models",
               :desc => "Define models package"

  class_option :controllers_package, :aliases => "-c", :default => "controllers",
               :desc => "Define controllers package"

  class_option :repositories_package, :aliases => "-r", :default => "repositories",
               :desc => "Define repositories package"

  class_option :skip_jquery, :type => :boolean, :aliases => "-j",
               :desc => "Skip jQuery download file"

  class_option :skip_eclipse, :type => :boolean, :aliases => "-E",
               :desc => "Skip Eclipse files"

  def self.source_root
    File.join File.dirname(__FILE__), "templates"
  end

  def initialize(args, opts=[])
    super([args], opts)
    validate
    self.destination_root=(project_path)
    @project_name = project_path.split("/").last
    @dependencies = DependencyManager.new({:gae => true}).dependencies
  end

  def create_root_folder
    empty_directory "."
  end

  def configure_ant
    create_eclipse_files unless options[:skip_eclipse]
    copy_file("build.xml")
    template("build.properties.erb", "build.properties")
    template("ivy.erb", "ivy.xml")
    copy_file(AppGenerator::IVY_JAR)
    copy_file("gae/ivysettings.xml", "ivysettings.xml")
  end

  def configure_vraptor_packages
    @vraptor_packages = ["br.com.caelum.vraptor.gae"]
  end

  def create_main_java
    empty_directory Configuration::MAIN_SRC
    @src = File.join(Configuration::MAIN_SRC, options[:package].gsub(".", File::Separator))
  end

  def create_controllers_directory
    empty_directory File.join @src, options[:controllers_package]
  end

  def create_models_directory
    empty_directory File.join(@src, options[:models_package])
  end

  def create_repositories_directory
    repositories_folder = File.join @src, options[:repositories_package]
    empty_directory repositories_folder
    template("orm/Repository-objectify.java.tt", "#{repositories_folder}/Repository.java")
  end

  def create_main_resources
    directory("resources", Configuration::MAIN_RESOURCES)
  end

  def configure_orm
    infra_folder = File.join @src, "infra"
    empty_directory infra_folder
    template("gae/ObjectifyFactory.java.tt", "#{@src}/infra/ObjectifyFactory.java")
  end

  def create_webapp
    directory("webapp", Configuration::WEB_APP)
    template("gae/appengine-web.xml.tt", "#{Configuration::WEB_INF}/appengine-web.xml")
    copy_file("gae/logging.properties", "#{Configuration::WEB_INF}/logging.properties")
  end

  def create_javascripts
    javascripts = File.join Configuration::WEB_APP, "javascripts"
    create_file File.join javascripts, "application.js"
    unless options[:skip_jquery]
      jquery = get_jquery
      add_file (File.join javascripts, "jquery.min.js"), jquery.body if jquery
    end
  end

  def configure_scaffold_properties
    template("vraptor-scaffold-gae.erb", Configuration::FILENAME)
  end

  def configure_template_engine
    JspTemplateEngine.new(project_path, @options).configure
  end

  def create_test
    empty_directory Configuration::TEST_SRC
    test_src = File.join(Configuration::TEST_SRC, options[:package].gsub(".", File::Separator))

    empty_directory File.join test_src, options[:controllers_package]
    empty_directory File.join test_src, options[:models_package]
    empty_directory File.join test_src, options[:repositories_package]

    directory("resources-test", Configuration::TEST_RESOURCES)
  end

  private
  def orm
    return "objectify"
  end

  def create_eclipse_files
    template("eclipse/classpath-gae.erb", ".classpath")
    template("eclipse/project-gae.erb", ".project")
    directory("eclipse/settings-gae", ".settings")
  end

  def validate
    if File.directory? project_path
      puts "The project #{project_path} already exist"
      Kernel::exit
    end
  end

  def jquery_uri
    "/ajax/libs/jquery/1/jquery.min.js"
  end

  def get_jquery
    begin
      VraptorScaffold::HttpRequest.open_session("ajax.googleapis.com").get jquery_uri;
    rescue
      Kernel.puts "Was not possible to download jQuery."
    end
  end
end
