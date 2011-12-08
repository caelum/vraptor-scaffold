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
      :big_integer => ["java.math.BigInteger"],
      :date => ["java.util.Date"],
      :local_date => ["org.joda.time.LocalDate", "org.hibernate.annotations.Type"],
      :local_date_time => ["org.joda.time.LocalDateTime", "org.hibernate.annotations.Type"],
      :local_time => ["org.joda.time.LocalTime", "org.hibernate.annotations.Type"],
      :references => ["javax.persistence.ManyToOne"]
    }
  end
  
end