class AppGenerator < Thor::Group
  include Thor::Actions
  
  def self.source_root
    File.dirname(__FILE__)
  end
      
  def build(project_name)
    self.destination_root=(project_name)
    empty_directory "."
    create_main_java
  end
  
  private
    def create_main_java
      main_java = "src/main/java"
      empty_directory main_java
      inside main_java do
        app_files
      end
    end
    
    def app_files
      empty_directory "app"
      inside "app" do
        empty_directory "controllers"
        empty_directory "models"
        app_infra
      end
    end
    
    def app_infra
      infra_path = empty_directory "infrastructure"
      in_root do
        path_resolver = "#{infra_path}/FreemarkerPathResolver.java"
        template('templates/FreemarkerPathResolver.java', path_resolver)
      end
    end
end
