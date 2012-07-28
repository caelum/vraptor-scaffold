class JspTemplateEngine < VraptorScaffold::Base

  def self.source_root
    File.join(File.dirname(__FILE__), "templates", "jsp")
  end

  def initialize(project_path, options)
    super
    self.destination_root=(project_path)
    @options = options
  end

  def configure
    template("../decorators.erb", File.join(Configuration::WEB_INF, "decorators.xml"))
    template("main.jsp.erb", File.join(Configuration::WEB_INF, decorators_path, "main.jsp"))
    copy_file("prelude.jspf", File.join(Configuration::WEB_INF, "jsp", "prelude.jspf"))
    append_prelude_config
  end

  def extension
    "jsp"
  end

  def decorators_path
    File.join "jsp", "decorators"
  end

  private
  def append_prelude_config
    file = File.join(Configuration::WEB_INF, "web.xml")
    template = File.join JspTemplateEngine.source_root, "jsp-web.xml"
    inject_into_file(file, File.read(template), :before => "</web-app>", :verbose => false)
  end
end
