class Attribute
  attr_accessor :name, :type
  
  def initialize(name, type)
    @name = name
    @type = type.capitalize
  end
  
  def self.valid_types
    %w(boolean double float short integer long string)
  end
end
