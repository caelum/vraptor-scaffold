class JspGenerator < TemplateEngineGenerator

  def view_folder
    "jsp"
  end

  def extension
    "jsp"
  end

  def path url=""
    %Q{${pageContext.request.contextPath}/#{base_path}#{url}}
  end
  
  def source_root
    File.join File.dirname(__FILE__), "templates"
  end
  
end
