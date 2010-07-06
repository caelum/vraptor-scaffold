class ControllerGenerator < BaseScaffold
  
  def self.source_root
    File.dirname(__FILE__)
  end
  
  def build
    template("templates/controller.erb", "src/main/java/app/controllers/#{controller_class_name}.java")
  end
  
  def controller_class_name
    "#{@model.capitalize}Controller"
  end
  
  def path
    "/#{@model.pluralize}"
  end
end
