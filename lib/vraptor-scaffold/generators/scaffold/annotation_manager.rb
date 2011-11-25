
class AnnotationManager
  
  attr_accessor :type 
  
  def initialize(type)
    @type = type
  end
  
  def annotation
    annotations[type.to_sym] or []
  end
  
  def annotations
    {
      :references => ["ManyToOne"]
    }
  end
  
end