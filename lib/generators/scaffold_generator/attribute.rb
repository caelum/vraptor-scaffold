class Attribute
  attr_accessor :name, :type
  
  def initialize(name, type)
    @name = name
    @type = type
  end
  
  def html_input
    input = "text"
    input = "checkbox" if boolean?
    input = "textarea" if type.eql?("text")
    input
  end
  
  def java_type
    java = type.capitalize
    java = "boolean" if boolean?
    java = "String" if type.eql?("text")
    java
  end
  
  def self.valid_types
    %w(boolean double float short integer long string text)
  end
  
  def boolean?
    type.eql? "boolean"
  end
end
