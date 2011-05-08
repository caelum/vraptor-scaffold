class JspGenerator < TemplateEngineGenerator

  def self.source_root
    File.dirname(__FILE__)
  end

  def view_folder
    "jsp"
  end

  def extension
    "jsp"
  end

  def path url=""
    %Q{${pageContext.request.contextPath}/#{@model.pluralize}#{url}}
  end
end
