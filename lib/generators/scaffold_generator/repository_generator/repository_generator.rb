class RepositoryGenerator < BaseScaffold

  def self.source_root
    File.dirname(__FILE__)
  end

  def build
    template("templates/repository.erb", "#{Configuration::MAIN_SRC}/app/repositories/#{repository_interface_name}.java")
    template("templates/repository_impl.erb", "#{Configuration::MAIN_SRC}/app/repositories/#{repository_impl_name}.java")    
    template("templates/repository_test.erb", "#{Configuration::TEST_SRC}/app/repositories/#{repository_test_class_name}.java")
  end
end
