class BaseScaffold < VraptorScaffold::Base
  
  def initialize(model, attributes={})
    super
    @model = model
    @attributes = attributes
  end
  
  def class_name
    @model.capitalize
  end
  
  def repository_class_name
   	"#{class_name}Repository"
  end
  
  def controller_class_name
    "#{class_name}Controller"
  end
end
