class ModelGenerator < BaseScaffold
  
  def self.source_root
    File.dirname(__FILE__)
  end
  
  def build
    template("templates/model.erb", "src/main/java/app/models/#{class_name}.java")
  end
end
