class TemplateEngineGenerator < BaseScaffold

  def build
    define_source_paths
    create_view("index")
    create_view("show")
    create_view("form")
    create_view("edit")
    create_view("new", "new#{class_name}")
  end

  def create_view(template_name, file_name=template_name)
    template("#{template_name}.erb", "#{views_path}/#{file_name}.#{extension}")
  end

  def views_path
    File.join Configuration::WEB_INF, view_folder, model_parameter_name
  end
  
  def template_path
    "src/templates/views"
  end

end

require File.dirname(__FILE__) + "/jsp_generator/jsp_generator"
require File.dirname(__FILE__) + "/freemarker_generator/freemarker_generator"