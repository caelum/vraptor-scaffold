class ScaffoldGenerator < VraptorScaffold::Base
  
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
    template("templates/controller.erb", "src/main/java/app/controllers/#{@model.capitalize}Controller.java")
    template("templates/views/index.erb", "src/main/webapp/WEB-INF/freemarker/#{@model}/index.ftl")
     template("templates/views/index.erb", "src/main/webapp/WEB-INF/freemarker/#{@model}/show.ftl")
      template("templates/views/index.erb", "src/main/webapp/WEB-INF/freemarker/#{@model}/new.ftl")
       template("templates/views/index.erb", "src/main/webapp/WEB-INF/freemarker/#{@model}/edit.ftl")
  end
end
