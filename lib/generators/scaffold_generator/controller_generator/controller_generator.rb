class ControllerGenerator < BaseScaffold
  
  def self.source_root
    File.dirname(__FILE__)
  end
  
  def build
    template("templates/controller.erb", "#{Configuration::MAIN_SRC}/app/controllers/#{controller_class_name}.java")
    template("templates/controller_test.erb", "#{Configuration::TEST_SRC}/app/controllers/#{controller_test_class_name}.java")
  end
  
  def path
    "/#{@model.pluralize}"
  end
end
