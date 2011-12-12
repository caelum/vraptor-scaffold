class ImportManager
  
  attr_accessor :type
  
  def initialize(type)
    @type = type
    packages
  end
  
  def package
    packages[type.to_sym] or []
  end
  
  def packages
    {
      :big_decimal => ["java.math.BigDecimal"],
      :references => ["javax.persistence.ManyToOne"]
    }
  end
  
end