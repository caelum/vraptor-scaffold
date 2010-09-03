class FreemarkerTemplateEngine < VraptorScaffold::Base

  def self.source_root
    File.join(File.dirname(__FILE__), "templates")
  end

  def initialize(project_path)
    super
    self.destination_root=(project_path)
  end

  def configure
    directory("macros", File.join(Configuration::WEB_APP, "macros"))
    template("decorators.erb", File.join(Configuration::WEB_INF, "decorators.xml"))
    copy_file("freemarker-web.xml", File.join(Configuration::WEB_INF, "web.xml"))
    copy_file("main.ftl", File.join(Configuration::WEB_INF, "decorators", "main.ftl"))
    directory("infrastructure", File.join(Configuration::MAIN_SRC, "app", "infrastructure"))
    empty_directory File.join(Configuration::WEB_INF, "views")
  end

  def extension
    "ftl"
  end
end
