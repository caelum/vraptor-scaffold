class FreemarkerTemplateEngine < VraptorScaffold::Base

  def self.source_root
    File.join(File.dirname(__FILE__), "templates", "freemarker")
  end

  def initialize(project_path, options)
    super
    self.destination_root=(project_path)
    @project_path = project_path
    @options = options
  end

  def configure
    directory("macros", File.join(Configuration::WEB_APP, "macros"))
    template("../decorators.erb", File.join(Configuration::WEB_INF, "decorators.xml"))
    copy_file("main.ftl", File.join(Configuration::WEB_INF, decorators_path, "main.ftl"))
    directory("infrastructure", infra_path)
    append_freemarker_servlet
  end

  def extension
    "ftl"
  end

  def decorators_path
    File.join "views", "decorators"
  end

  def package
    file = File.join(@project_path, Configuration::FILENAME)
    package = YAML.load_file(file)['package']
  end

  private
  def append_freemarker_servlet
    file = File.join(Configuration::WEB_INF, "web.xml")
    template = File.join FreemarkerTemplateEngine.source_root, "freemarker-web.xml"
    inject_into_file(file, File.read(template), :before => "</web-app>", :verbose => false)
  end

  def infra_path
    File.join Configuration::MAIN_SRC, package.gsub(".", File::Separator), "infrastructure"
  end
end
