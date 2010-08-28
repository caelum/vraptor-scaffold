class ModelGenerator < BaseScaffold

  def self.source_root
    File.dirname(__FILE__)
  end

  def build
    template("templates/model.erb", "#{Configuration::MAIN_SRC}/app/models/#{class_name}.java")
    template("templates/model_test.erb", "#{Configuration::TEST_SRC}/app/models/#{test_class_name}.java")
  end
end
