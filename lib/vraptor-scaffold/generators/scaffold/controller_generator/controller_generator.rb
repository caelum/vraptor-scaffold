class ControllerGenerator < BaseScaffold

  def self.source_root
    File.join File.dirname(__FILE__), "templates"
  end

  def build
    template("controller.erb", Configuration.main_class_path(Configuration.controllers_package, "#{controller_class_name}.java"))
    template("controller_test.erb", Configuration.test_class_path(Configuration.controllers_package, "#{controller_test_class_name}.java"))
  end

  def path
    "/#{@model.downcase.pluralize}"
  end
end
