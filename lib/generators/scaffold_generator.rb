class ScaffoldGenerator < Thor::Group
  include Thor::Actions
  
  def self.source_root
    File.dirname(__FILE__)
  end
  
  def build(args)
    @model = args.delete_at(0).downcase
    @path = "/#{@model.pluralize}"
    @attributes = []
    args.each do |arg|
      parsedAttribute = arg.split(":")
      @attributes << Attribute.new(parsedAttribute[0], parsedAttribute[1].capitalize)
    end
    template("templates/scaffold/controller.erb", "src/main/java/app/controllers/#{@model.capitalize}Controller.java")
    template("templates/scaffold/model.erb", "src/main/java/app/models/#{@model.capitalize}.java")
  end
end
