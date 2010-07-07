class ScaffoldGenerator
  
  attr_accessor :attributes, :model
  
  def initialize(args)
  	@model = args.delete_at(0).downcase 
  	parse_attributes(args)
  end
  
  def build
  	ModelGenerator.new(model, attributes).build
  	ControllerGenerator.new(model, @attributes).build
  	FreemarkerGenerator.new(model, @attributes).build
  end
  
  private 
    def parse_attributes(args)
      @attributes = []
      args.each do |arg|
        parsedAttribute = arg.split(":")
        @attributes << Attribute.new(parsedAttribute[0], parsedAttribute[1].capitalize)
      end
    end
end
