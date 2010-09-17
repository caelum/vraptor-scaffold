class ScaffoldGenerator

  attr_accessor :attributes, :model

  def initialize(args)
    @model = args.shift.downcase 
    @attributes = []
    validate_scaffold_command(args)
  end

  def build
    ModelGenerator.new(model, attributes).build
    RepositoryGenerator.new(model, attributes).build
    ControllerGenerator.new(model, attributes).build
    templates = {"jsp" => JspGenerator, "ftl" => FreemarkerGenerator}
    templates[Configuration.template_engine].new(model, attributes).build
  end

  private 
  def validate_scaffold_command(args)
    unless File.exist?("src")
      puts "To run scaffold please go to the project root folder."
      Kernel::exit
    end
    validate_attributes(args)
  end

  def validate_attributes(args)
    args.each do |arg|
      parsedAttribute = arg.split(":")
      parse_attribute(parsedAttribute)
    end
  end

  def parse_attribute(parsedAttribute) 
    type = parsedAttribute.last.downcase 
    unless Attribute.valid_types.include?(type)
      puts "Attribute #{type} is not supported. The supported attributes types are: #{Attribute.valid_types.join(" ")}"
      Kernel::exit
    end
    @attributes << Attribute.new(parsedAttribute.first, type)
  end
end
