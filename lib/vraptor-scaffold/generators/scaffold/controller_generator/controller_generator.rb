class ControllerGenerator < BaseScaffold
  
  def build
    define_source_paths
    template("controller.erb", Configuration.main_class_path(Configuration.controllers_package, "#{controller_class_name}.java"))
    template("controller_test.erb", Configuration.test_class_path(Configuration.controllers_package, "#{controller_test_class_name}.java"))
  end
  
  def template_path
    "src/templates/controllers"
  end
  
  def source_root
    File.join File.dirname(__FILE__), "templates"
  end

  def path
    "/#{base_path}"
  end
end
