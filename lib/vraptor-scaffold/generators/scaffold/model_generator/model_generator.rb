class ModelGenerator < BaseScaffold

  def build
    define_source_paths
    template("model.erb", Configuration.main_class_path(Configuration.models_package, "#{class_name}.java"))
    template("model_test.erb", Configuration.test_class_path(Configuration.models_package, "#{test_class_name}.java"))
    map_orm_class if Configuration.hibernate?
  end

  def template_path
    "src/templates/models"
  end
  
  def source_root
    File.join File.dirname(__FILE__), "templates"
  end

  private
  def map_orm_class
    file = File.join Configuration::MAIN_RESOURCES, "hibernate.cfg.xml"
    model = "#{Configuration.full_models_package}.#{class_name}"
    line_break = "\n	"
    inject_into_file(file, "	<mapping class='#{model}'/>#{line_break}", :before => "</session-factory>")
  end
    
end
