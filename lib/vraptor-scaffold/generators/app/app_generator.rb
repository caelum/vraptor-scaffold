class AppGenerator < VraptorScaffold::Base

  TEMPLATE_ENGINES = %w( jsp ftl )
  BUILD_TOOLS = %w( ant mvn gradle )
  ORMS = %w( jpa hibernate )
  IVY_JAR = "ivy-2.2.0.jar"

  argument :project_path

  class_option :template_engine, :default => "jsp", :aliases => "-e",
               :desc => "Template engine (options: #{TEMPLATE_ENGINES.join(', ')})"

  class_option :package, :default => "app", :aliases => "-p",
               :desc => "Define base package"

  class_option :models_package, :aliases => "-m", :default => "models",
               :desc => "Define models package"

  class_option :controllers_package, :aliases => "-c", :default => "controllers",
               :desc => "Define controllers package"

  class_option :heroku, :type => :boolean, :aliases => "-h",
               :desc => "heroku project"

  class_option :repositories_package, :aliases => "-r", :default => "repositories",
               :desc => "Define repositories package"

  class_option :build_tool, :default => "ant", :aliases => "-b",
               :desc => "Build tools (options: #{BUILD_TOOLS.join(', ')})"

  class_option :orm, :default => "jpa", :aliases => "-o",
               :desc => "Object-relational mapping (options: #{ORMS.join(', ')})"

  class_option :jquery, :aliases => "-j", :default => "latest version",
               :desc => "jQuery version"

  class_option :skip_eclipse, :type => :boolean, :aliases => "-E",
               :desc => "Skip Eclipse files"

  def self.source_root
    File.join File.dirname(__FILE__), "templates"
  end

  def self.banner
    "vraptor new #{self.arguments.map(&:usage).join(' ')} [options]"
  end

  def initialize(args, opts=[])
    super([args], opts)
    validate
    self.destination_root=(project_path)
    @project_name = project_path.split("/").last
    @dependency_manager = DependencyManager.new(options)
  end

  def create_root_folder
    empty_directory "."
    if @options[:heroku]
      copy_file("heroku/Procfile", "Procfile")
    end
  end

  def configure_maven
    template("pom.erb", "pom.xml") if build_tool == "mvn"
  end

  def configure_ant
    if build_tool == "ant"
      create_eclipse_files unless options[:skip_eclipse]
      copy_file("build.xml")
      template("build.properties.erb", "build.properties")
      template("ivy.erb", "ivy.xml")
      copy_file(IVY_JAR)
    end
  end

  def configure_gradle
    template("build.gradle.erb", "build.gradle") if build_tool == "gradle"
  end

  def create_main_java
    empty_directory Configuration::MAIN_SRC
    @src = File.join(Configuration::MAIN_SRC, options[:package].gsub(".", File::Separator))
    if @options[:heroku]
      copy_file("heroku/Main.java", "#{Configuration::MAIN_SRC}/Main.java")
    end
  end

  def create_controllers_directory
    empty_directory File.join @src, options[:controllers_package]
  end

  def create_models_directory
    models_folder = File.join @src, options[:models_package]
    empty_directory models_folder
    template("models/Entity.erb", "#{models_folder}/Entity.java")
  end

  def create_repositories_directory
    repositories_folder = File.join @src, options[:repositories_package]
    empty_directory repositories_folder
    template("orm/Repository-#{options[:orm]}.java.tt", "#{repositories_folder}/Repository.java")
  end

  def create_main_resources
    directory("resources", Configuration::MAIN_RESOURCES)
  end

  def configure_orm
    if (options[:orm] == "hibernate")
      copy_file("orm/hibernate.cfg.xml", (File.join Configuration::MAIN_RESOURCES, "hibernate.cfg.xml"))
    else
      metainf = File.join Configuration::MAIN_RESOURCES, 'META-INF'
      empty_directory metainf
      copy_file("orm/persistence.xml", (File.join metainf, "persistence.xml"))
    end
  end

  def create_webapp
    directory("webapp", Configuration::WEB_APP)
  end

  def create_javascripts
    javascripts = File.join Configuration::WEB_APP, "javascripts"
    create_file File.join javascripts, "application.js"
    http_request_for_jquery_repo = http_request(jquery_repo)
    jquery_min = http_request_for_jquery_repo.get(jquery_uri)
    add_file (File.join javascripts, "jquery.min.js"), jquery_min.body
  end

  def configure_scaffold_properties
    template("vraptor-scaffold.erb", Configuration::FILENAME)
  end

  def configure_template_engine
    templates = {"jsp" => JspTemplateEngine, "ftl" => FreemarkerTemplateEngine}
    templates[options[:template_engine]].new(project_path).configure if templates[options[:template_engine]]
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
  def build_tool
    return "mvn" if options[:heroku]
    options[:build_tool]
  end

  def jquery_repo
    "ajax.googleapis.com"
  end

  def jquery_uri
    jquery_version = "1" #this mean get latest version
    jquery_version = options[:jquery] if options[:jquery] != 'latest version'
    "/ajax/libs/jquery/#{jquery_version}/jquery.min.js"
  end

  def create_eclipse_files
    template("eclipse/project.erb", ".project")
    template("eclipse/classpath.erb", ".classpath")
    directory("eclipse/settings", ".settings")
  end

  require 'net/http'
  require 'uri'
  def validate
    unless BUILD_TOOLS.include? options[:build_tool]
      puts "Build tool #{options[:build_tool]} is not supported. The supported build tools are: #{BUILD_TOOLS.join(", ")}"
      Kernel::exit
    end
    unless TEMPLATE_ENGINES.include? options[:template_engine]
      puts "Template engine #{options[:template_engine]} is not supported. The supported template engines are: #{TEMPLATE_ENGINES.join(", ")}"
      Kernel::exit
    end
    unless ORMS.include? options[:orm]
      puts "ORM #{options[:orm]} is not supported. The supported object-relational mapping are: #{ORMS.join(", ")}"
      Kernel::exit
    end

    if File.directory? project_path
      puts "The project #{project_path} already exist"
      Kernel::exit
    end

    if options[:jquery] != 'latest version'
      http = http_request(jquery_repo)
      case http.get(jquery_uri)
      when Net::HTTPClientError, Net::HTTPServerError
        download_url = "http://docs.jquery.com/Downloading_jQuery"
        puts "jQuery version #{options[:jquery]} was not found. Please visit the download page to see the versions available #{download_url}."
        Kernel::exit
      end
    end
  end

  def http_request(url)
    return Net::HTTP.start(url) unless ENV['http_proxy']

    uri = URI.parse(ENV['http_proxy'])
    proxy_user, proxy_pass = uri.userinfo.split(/:/) if uri.userinfo
    Net::HTTP::Proxy(uri.host, uri.port, proxy_user, proxy_pass).start(url)
  end
end
