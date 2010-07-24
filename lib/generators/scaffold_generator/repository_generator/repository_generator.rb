class RepositoryGenerator < BaseScaffold
  
  def self.source_root
    File.dirname(__FILE__)
  end
  
  def build
    template("templates/repository.erb", "src/main/java/app/repositories/#{class_name}Repository.java")
  end
  
  def repository_class_name
    "#{class_name}Repository"
  end
end
