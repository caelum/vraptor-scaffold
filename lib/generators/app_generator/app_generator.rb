class AppGenerator < VraptorScaffold::Base
  
   def self.source_root
      File.dirname(__FILE__)
   end
  
  def build(project_path)
    @project_name = project_path.split("/").last
    self.destination_root=(project_path)
    empty_directory "."
    create_pom
    create_main_java
    create_main_resources
    create_webapp
    empty_directory "src/test/java"
    empty_directory "src/test/resources"
  end
  
  private
  	def create_pom
  		template("templates/pom.erb", "pom.xml")
  	end
  
    def create_main_java
      main_java = "src/main/java"
      empty_directory main_java
      inside main_java do
        create_app
      end
    end
    
    def create_app
      empty_directory "app"
      inside "app" do
        empty_directory "controllers"
        create_app_models
        create_app_infra
        create_app_repository
      end
    end
    
    def create_app_models
      models_path = empty_directory "models"
      template = "Entity.java"
      template_from_root(template, "#{models_path}/#{template}")
    end
    
    def create_app_infra
      infra_path = empty_directory "infrastructure"
      template = "FreemarkerPathResolver.java"
      template_from_root(template, "#{infra_path}/#{template}")
    end
    
    def create_app_repository
      repository_path = empty_directory "repositories"
      template = "Repository.java"
      template_from_root(template, "#{repository_path}/#{template}")
    end
    
    def create_main_resources
      main_resources = "src/main/resources"
      empty_directory main_resources
      inside main_resources do
        template_from_root("log4j.properties", "#{main_resources}/log4j.properties")
        template_from_root("messages.properties", "#{main_resources}/messages.properties")
        meta_inf = empty_directory "META-INF"
        template_from_root("persistence.xml", "#{meta_inf}/persistence.xml")
      end
    end
    
    def create_webapp
      webapp = "src/main/webapp"
      empty_directory webapp
      inside webapp do
        template_from_root("index.jsp", "#{webapp}/index.jsp")
        create_decorators
        create_js
        create_css
        create_macros
        create_web_inf
      end
    end
    
    def create_macros
      macros = empty_directory "macros"
      inside "macros" do
        template_from_root("macros/html.ftl", "#{macros}/html.ftl")
      end
    end
    
    def create_css
      css = empty_directory "stylesheets"
      inside "stylesheets" do
        template_from_root("stylesheets/scaffold.css", "#{css}/scaffold.css")
      end
    end
    
     def create_js
      js = empty_directory "javascripts"
      inside "javascripts" do
        template_from_root("javascripts/jquery-1.4.2.min.js", "#{js}/jquery-1.4.2.min.js")
      end
    end
    
    def create_decorators
      decorators = empty_directory "decorators"
      inside decorators do
        template_from_root("main.ftl", "#{decorators}/main.ftl")
      end
    end
    
    def create_web_inf
      web_inf = empty_directory "WEB-INF"
      inside "WEB-INF" do
        template_from_root("decorators.xml", "#{web_inf}/decorators.xml")
        template_from_root("web.xml", "#{web_inf}/web.xml")
        empty_directory "views"
      end
    end
    
    def template_from_root(template, to)
      in_root do
        template("templates/#{template}", to)
      end
    end
end
