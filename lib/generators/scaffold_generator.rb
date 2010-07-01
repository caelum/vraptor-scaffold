class ScaffoldGenerator < Thor::Group
  include Thor::Actions
  
  def self.source_root
    File.dirname(__FILE__)
  end
  
  def build(args)
    @model = args[0].capitalize
    template("templates/scaffold/model.erb", "src/main/java/app/models/#{@model}.java")
  end
end
