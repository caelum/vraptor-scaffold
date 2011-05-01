class ModelGenerator < BaseScaffold

  def self.source_root
    File.join File.dirname(__FILE__), "templates"
  end

  def build
    template("model.erb", Configuration.main_class_path("models", "#{class_name}.java"))
    template("model_test.erb", Configuration.test_class_path("models", "#{test_class_name}.java"))
    map_orm_class if Configuration.orm.eql? 'hibernate'
  end

  private
  def map_orm_class
    file = File.join Configuration::MAIN_RESOURCES, "hibernate.cfg.xml"
    model = "#{Configuration.package}.models.#{class_name}"
    line_break = "\n	"
    inject_into_file(file, "	<mapping class='#{model}'/>#{line_break}", :before => "</session-factory>")
  end
end
