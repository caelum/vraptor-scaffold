class BaseScaffold < VraptorScaffold::Base
  
  def initialize(args)
    super
    @model = args.delete_at(0).downcase 
    parse_attributes args
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
