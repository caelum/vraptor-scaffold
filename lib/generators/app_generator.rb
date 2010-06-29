class AppGenerator < Thor::Group
  include Thor::Actions
  
  def self.source_root
    File.dirname(__FILE__)
  end
      
  def build(project_name)
    self.destination_root=(project_name)
    empty_directory "."
    create_main_java
    create_main_resources
  end
  
  private
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
        empty_directory "models"
        create_app_infra
      end
    end
    
    def create_app_infra
      infra_path = empty_directory "infrastructure"
      template = "FreemarkerPathResolver.java"
      template_from_root(template, "#{infra_path}/#{template}")
    end
    
    def create_main_resources
      main_resources = "src/main/resources"
      empty_directory main_resources
      inside main_resources do
        template_from_root("log4j.xml", "#{main_resources}/log4j.xml")
        empty_directory "META-INF"
      end
    end
    
    def template_from_root(template, to)
      in_root do
        template("templates/#{template}", to)
      end
    end
end
