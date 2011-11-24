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
  
  def template_path
    "src/templates/engine"
  end
  
  def source_root
    "template_engine_generator/jsp_generator/templates"
  end
  
end
