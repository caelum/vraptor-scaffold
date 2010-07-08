class FreemarkerGenerator < BaseScaffold
  
  def self.source_root
    File.dirname(__FILE__)
  end
  
  def build
    template("templates/index.erb", "src/main/webapp/WEB-INF/freemarker/#{@model}/index.ftl")
    template("templates/show.erb", "src/main/webapp/WEB-INF/freemarker/#{@model}/show.ftl")
    template("templates/new.erb", "src/main/webapp/WEB-INF/freemarker/#{@model}/new#{class_name}.ftl")
    template("templates/edit.erb", "src/main/webapp/WEB-INF/freemarker/#{@model}/edit.ftl")
  end
  
  def path
    "${base}/#{@model.pluralize}"
  end
end
