class FreemarkerTemplateEngine < VraptorScaffold::Base

  def self.source_root
    File.join(File.dirname(__FILE__), "templates")
  end

  def initialize(project_path, template)
    super
    self.destination_root=(project_path)
  end

  def configure
    directory("macros", File.join(Configuration::WEB_APP, "macros"))
    template("main.ftl", File.join(Configuration::WEB_APP, "decorators/main.ftl"))
    template("decorators.erb", File.join(Configuration::WEB_INF, "decorators.xml"))
  end

  def extension
    "ftl"
  end
end
