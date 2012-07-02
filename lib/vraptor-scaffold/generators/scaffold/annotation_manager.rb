
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
      :local_date => ["Type(type=\"org.joda.time.contrib.hibernate.PersistentLocalDate\")"],
      :local_time => ["Type(type=\"org.joda.time.contrib.hibernate.PersistentLocalTimeAsTime\")"],
      :local_date_time => ["Type(type=\"org.joda.time.contrib.hibernate.PersistentLocalDateTime\")"],      
      :references => ["ManyToOne"]
    }
  end
  
end