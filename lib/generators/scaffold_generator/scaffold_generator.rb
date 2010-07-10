class ScaffoldGenerator
  
  attr_accessor :attributes, :model
  
  def initialize(args)
    unless File.exist?("pom.xml")
      puts "To run scaffold please go to project root folder."
      Kernel::exit
    end
  	@model = args.shift.downcase 
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
