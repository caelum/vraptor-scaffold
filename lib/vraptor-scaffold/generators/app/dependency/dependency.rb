class Dependency

  attr_accessor :group, :name, :version, :exclusions

  def initialize group, name, version=nil, exclusions=[]
    @group = group
    @name = name
    @version = version
    @exclusions = exclusions
  end

  def has_exclusions?
    !@exclusions.empty?
  end
end