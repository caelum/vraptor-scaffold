class BaseScaffold < VraptorScaffold::Base

  def initialize(model, attributes={})
    super
    @model = model
    @attributes = attributes
  end
      
  def model_parameter_name
    @model.camelize(:lower)
  end

  def class_name
    @model.camelize
  end

  def test_class_name
    "#{class_name}Test"
  end

  def repository_interface_name
    "#{class_name}Repository"
  end

  def repository_impl_name
    "#{repository_interface_name}Impl"
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

  def base_path
    model_parameter_name.pluralize
  end
  
  protected
  def define_source_paths
    source_paths << File.expand_path(template_path) if File.exists?(template_path)
    source_paths << File.join(File.dirname(__FILE__), source_root)    
  end
  
  def source_root
    raise "abstract method"
  end
  
  def template_path
    raise "abstract method"
  end
  
end
