class FreemarkerTemplateEngine < VraptorScaffold::Base

  def self.source_root
    File.join(File.dirname(__FILE__), "templates", "freemarker")
  end

  def initialize(project_path)
    super
    self.destination_root=(project_path)
    @project_path = project_path
  end

  def configure
    directory("macros", File.join(Configuration::WEB_APP, "macros"))
    template("../decorators.erb", File.join(Configuration::WEB_INF, "decorators.xml"))
    copy_file("freemarker-web.xml", File.join(Configuration::WEB_INF, "web.xml"))
    copy_file("main.ftl", File.join(Configuration::WEB_INF, "decorators", "main.ftl"))
    directory("infrastructure", infra_path)
    empty_directory File.join(Configuration::WEB_INF, "views")
    dependencies
  end

  def extension
    "ftl"
  end

  def package
    file = File.join(@project_path, Configuration::FILENAME)
    package = YAML.load_file(file)['package']
  end

  private 
  def infra_path
    File.join Configuration::MAIN_SRC, package.gsub(".", File::Separator), "infrastructure"
  end

  def dependencies
    template = File.join FreemarkerTemplateEngine.source_root, "freemarker-dep.xml"
    inject_into_file "pom.xml", File.read(template), :after => "<dependencies>", :verbose => false
  end
end
