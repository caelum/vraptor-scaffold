class FreemarkerGenerator < BaseScaffold
  
  def self.source_root
    File.dirname(__FILE__)
  end
  
  def build
    create_view("index")
    create_view("show")
    create_view("form")
  end
  
  def create_view(name)
  	 template("templates/#{name}.erb", "src/main/webapp/WEB-INF/views/#{@model}/#{name}.ftl")
  end
  
  def path
    "${base}/#{@model.pluralize}"
  end
end
