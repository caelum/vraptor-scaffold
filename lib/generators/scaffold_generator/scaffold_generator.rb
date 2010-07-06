class ScaffoldGenerator < VraptorScaffold::Base
  
  def self.source_root
    File.dirname(__FILE__)
  end
  
  def build(args)
    @model = args.delete_at(0).downcase
    template("templates/views/index.erb", "src/main/webapp/WEB-INF/freemarker/#{@model}/index.ftl")
     template("templates/views/index.erb", "src/main/webapp/WEB-INF/freemarker/#{@model}/show.ftl")
      template("templates/views/index.erb", "src/main/webapp/WEB-INF/freemarker/#{@model}/new.ftl")
       template("templates/views/index.erb", "src/main/webapp/WEB-INF/freemarker/#{@model}/edit.ftl")
  end
end
