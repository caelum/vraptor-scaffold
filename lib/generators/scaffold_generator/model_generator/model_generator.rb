class ModelGenerator < BaseScaffold

  def self.source_root
    File.join File.dirname(__FILE__), "templates"
  end

  def build
    template("model.erb", File.join(Configuration.models_path, "#{class_name}.java"))
    template("model_test.erb", File.join(Configuration.models_test_path, "#{test_class_name}.java"))
  end
end
