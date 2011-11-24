class FreemarkerGenerator < TemplateEngineGenerator

  def view_folder
    "views"
  end

  def extension
    "ftl"
  end

  def path
    "${base}/#{base_path}"
  end
  
  def template_path
    "src/templates/engine"
  end
  
  def source_root
    "template_engine_generator/freemarker_generator/templates"
  end
  
end
