class ScaffoldGenerator < VraptorScaffold::Base

  attr_accessor :generated_attributes
  argument :model
  argument :attributes, :type => :hash, :default => {}, :banner => "field:type field:type"


  def self.banner
    banner =  "vraptor scaffold #{self.arguments.map(&:usage).join(' ')}\n\n"
    banner += "  The supported types are: #{Attribute.valid_types.join(", ")}"
  end

  def initialize(args)
    super(args)
    @generated_attributes = []
    attributes.each { |field, type|
      @generated_attributes << Attribute.new(field, type)
    }
  end

  def controller_generator
    ControllerGenerator.new(model, @generated_attributes).build
  end

  def model_generator
    models_generator_available = {"jpa" => ModelGenerator,
                                  "hibernate" => ModelGenerator,
                                  "objectify" => ObjectifyModelGenerator }
    models_generator_available.fetch(Configuration.orm).new(model, @generated_attributes).build
  end

  def repository_generator
    repository_generators_available = {"jpa" => RepositoryGenerator,
                                       "hibernate" => RepositoryGenerator,
                                       "objectify" => ObjectifyRepositoryGenerator }
    repository_generators_available.fetch(Configuration.orm).new(model, @generated_attributes).build
  end

  def template_engine_generator
    templates = {"jsp" => JspGenerator, "ftl" => FreemarkerGenerator}
    templates[Configuration.template_engine].new(model, @generated_attributes).build
  end
end
