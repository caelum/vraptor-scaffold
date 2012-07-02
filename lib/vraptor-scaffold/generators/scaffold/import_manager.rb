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
      :date => ["java.util.Date"],
    }
  end

end
