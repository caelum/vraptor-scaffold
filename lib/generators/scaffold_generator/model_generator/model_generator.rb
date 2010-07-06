class ModelGenerator < BaseScaffold
  
  def self.source_root
    File.dirname(__FILE__)
  end
  
  def build
    template("templates/model.erb", "src/main/java/app/models/#{@model.capitalize}.java")
  end
  
  def class_name
    @model.capitalize
  end
end
