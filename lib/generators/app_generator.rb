class AppGenerator < Thor::Group
  include Thor::Actions
  #class_option :test_framework
  #argument :name
  
  #def self.source_root
    #File.dirname(__FILE__)
  #end
      
  #def create_file
    #template('templates/TemplateModel.ftl', "vraptor/lib/#{name}.rb") 
  #end
  
  def build(project_name)
    empty_directory(project_name)
  end
end
