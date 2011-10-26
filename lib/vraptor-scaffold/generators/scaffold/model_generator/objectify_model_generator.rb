class ObjectifyModelGenerator < BaseScaffold

  def self.source_root
    File.join File.dirname(__FILE__), "templates"
  end

  def build
    template("objectify_model.erb", Configuration.main_class_path(Configuration.models_package, "#{class_name}.java"))
    template("model_test.erb", Configuration.test_class_path(Configuration.models_package, "#{test_class_name}.java"))
    map_orm_class
  end

  private
  def map_orm_class
    file = File.join Configuration::main_class_path, "infra", "ObjectifyFactory.java"
    inject_into_file(file, "\t\tObjectifyService.register(#{class_name}.class);\n", :after => "\tstatic {\n")
  end
end
