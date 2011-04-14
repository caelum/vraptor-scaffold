class JspGenerator < BaseScaffold

  def self.source_root
    File.dirname(__FILE__)
  end

  def build
    create_view("index")
    create_view("show")
    create_view("form")
    create_view("edit")
    create_view("new", "new#{class_name}")
  end

  def create_view(template_name, file_name=template_name)
    template("templates/#{template_name}.erb", "#{Configuration::WEB_INF}/jsp/#{@model}/#{file_name}.jsp")
  end
  
  def path url=""
    %Q{${pageContext.request.contextPath}/#{@model.pluralize}#{url}}
  end
end
