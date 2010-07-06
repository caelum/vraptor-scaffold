class ScaffoldGenerator
  
  def build(args)
    ModelGenerator.new(args).build
    ControllerGenerator.new(args).build
    FreemarkerGenerator.new(args).build
  end
end
