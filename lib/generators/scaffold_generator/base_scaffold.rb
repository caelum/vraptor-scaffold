class BaseScaffold < VraptorScaffold::Base
  
  def initialize(model, attributes)
    super
    @model = model
    @attributes = attributes
  end
  
  def class_name
    @model.capitalize
  end
end
