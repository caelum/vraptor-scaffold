class ControllerGenerator < BaseScaffold
  
  def self.source_root
	File.join File.dirname(__FILE__), "templates"
  end
  
  def build
    template("controller.erb", File.join(Configuration.controllers_path, "#{controller_class_name}.java"))
    template("controller_test.erb", File.join(Configuration.controllers_test_path, "#{controller_test_class_name}.java"))
  end
  
  def path
    "/#{@model.pluralize}"
  end
end
