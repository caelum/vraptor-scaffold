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
  
  def source_root
    File.join File.dirname(__FILE__), "templates"
  end
  
end
