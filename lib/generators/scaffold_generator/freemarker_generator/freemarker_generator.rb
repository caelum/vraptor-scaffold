class FreemarkerGenerator < BaseScaffold
  
  def self.source_root
    File.dirname(__FILE__)
  end
  
  def build
    create_view("index")
    create_view("show")
    create_view("new", "new#{class_name}")
    create_view("edit")
  end
  
  def create_view(template_name, file_name=template_name)
  	 template("templates/#{template_name}.erb", "src/main/webapp/WEB-INF/views/#{@model.pluralize}/#{file_name}.ftl")
  end
  
  def path
    "${base}/#{@model.pluralize}"
  end
end
