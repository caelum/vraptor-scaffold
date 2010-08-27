class BaseScaffold < VraptorScaffold::Base
  
  def initialize(model, attributes={})
    super
    @model = model
    @attributes = attributes
  end
  
  def class_name
    @model.capitalize
  end
  
  def test_class_name
    "#{class_name}Test"
  end
  
  def repository_interface_name
   	"#{class_name}Repository"
  end
  
  def repository_impl_name
   	"#{class_name}RepositoryImpl"
  end
  
  def repository_test_class_name
   	"#{repository_impl_name}Test"
  end
  
  def controller_class_name
    "#{class_name}Controller"
  end
  
  def controller_test_class_name
    "#{controller_class_name}Test"
  end
end
