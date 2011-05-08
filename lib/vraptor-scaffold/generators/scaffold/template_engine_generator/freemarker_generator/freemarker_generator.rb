class FreemarkerGenerator < TemplateEngineGenerator

  def self.source_root
    File.dirname(__FILE__)
  end

  def view_folder
    "views"
  end

  def extension
    "ftl"
  end

  def path
    "${base}/#{@model.pluralize}"
  end
end
