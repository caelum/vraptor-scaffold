class ModelGenerator < BaseScaffold

  def self.source_root
    File.join File.dirname(__FILE__), "templates"
  end

  def build
    template("model.erb", Configuration.main_class_path("models", "#{class_name}.java"))
    template("model_test.erb", Configuration.test_class_path("models", "#{test_class_name}.java"))
  end
end
