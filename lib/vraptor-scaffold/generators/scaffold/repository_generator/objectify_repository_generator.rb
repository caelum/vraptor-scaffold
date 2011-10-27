class ObjectifyRepositoryGenerator < BaseScaffold

  def self.source_root
    File.join File.dirname(__FILE__), "templates"
  end

  def build
    template("objectify_repository.erb", Configuration.main_class_path(Configuration.repositories_package, "#{repository_interface_name}.java"))
    template("objectify_repository_impl.erb", Configuration.main_class_path(Configuration.repositories_package, "#{repository_impl_name}.java"))
    template("repository_test.erb", Configuration.test_class_path(Configuration.repositories_package, "#{repository_test_class_name}.java"))
  end

  def orm_import
    "com.googlecode.objectify.Objectify"
  end

  def orm_parameter_name
    "objectify"
  end

  def orm_class
    orm_parameter_name.camelize
  end

end
