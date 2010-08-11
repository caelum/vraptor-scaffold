class Attribute
  attr_accessor :name, :type
  
  def initialize(name, type)
    @name = name
    set_type(type)
  end
  
  def set_type(type)
    @type = type
    @type = @type.capitalize unless boolean?
  end
  
  def html_input
    input = "text"
    input = "checkbox" if boolean?
    input
  end
  
  def boolean?
    type.eql? "boolean"
  end
  
  def self.valid_types
    %w(boolean double float short integer long string)
  end
end
