class JspTemplateEngine < VraptorScaffold::Base

  def self.source_root
    File.join(File.dirname(__FILE__), "templates")
  end

  def initialize(project_path)
    super
    self.destination_root=(project_path)
  end

  def configure
    #directory("tags", File.join(Configuration::WEB_INF, "tags"))
    template("decorators.erb", File.join(Configuration::WEB_INF, "decorators.xml"))
    copy_file("jsp-web.xml", File.join(Configuration::WEB_INF, "web.xml"))
    copy_file("main.jsp", File.join(Configuration::WEB_INF, "decorators", "main.jsp"))
    empty_directory File.join(Configuration::WEB_INF, "jsp")
  end

  def extension
    "jsp"
  end
end
