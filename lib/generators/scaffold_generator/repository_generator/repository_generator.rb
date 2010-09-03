class RepositoryGenerator < BaseScaffold

  def self.source_root
    File.join File.dirname(__FILE__), "templates"
  end

  def build
    template("repository.erb", File.join(Configuration.repositories_path, "#{repository_interface_name}.java"))
    template("repository_impl.erb", File.join(Configuration.repositories_path, "#{repository_impl_name}.java"))    
    template("repository_test.erb", File.join(Configuration.repositories_test_path, "#{repository_test_class_name}.java"))
  end
end
