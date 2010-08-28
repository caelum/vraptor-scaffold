class RepositoryGenerator < BaseScaffold

  def self.source_root
    File.dirname(__FILE__)
  end

  def build
    template("templates/repository.erb", "src/main/java/app/repositories/#{repository_interface_name}.java")
    template("templates/repository_impl.erb", "src/main/java/app/repositories/#{repository_impl_name}.java")    
    template("templates/repository_test.erb", "src/test/java/app/repositories/#{repository_test_class_name}.java")
  end
end
