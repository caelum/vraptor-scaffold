class Dependency

  attr_accessor :group, :name, :version, :exclusions

  def initialize group, name, version=nil, exclusions=[]
    @group = group
    @name = name
    @version = version
    @exclusions = exclusions
  end

  def self.compile_scope(spring_version="2.5")
    dependencies = []
    if spring_version == "3.0"
      dependencies << self.new("br.com.caelum", "vraptor", "3.2.0",[self.new("org.springframework", "spring")])
      dependencies = dependencies + self.compile_scope_default_libs + self.compile_scope_spring3_libs
    else
      dependencies << self.new("br.com.caelum", "vraptor", "3.2.0") 
      dependencies = dependencies + self.compile_scope_default_libs
    end
    dependencies
  end

  def self.compile_scope_default_libs
    [ self.new("org.hsqldb", "hsqldb", "2.0.0"),
        self.new("opensymphony", "sitemesh", "2.4.2"), self.new("javax.servlet", "jstl", "1.2"),
        self.new("javax.persistence", "persistence-api", "1.0"), 
        self.new("org.hibernate", "hibernate-entitymanager", "3.4.0.GA"),
        self.new("org.hibernate", "hibernate-core", "3.3.2.GA"),
        self.new("org.hibernate", "hibernate-validator", "3.1.0.GA"),
        self.new("joda-time", "joda-time", "1.6")]
  end

  def self.compile_scope_spring3_libs
    [self.new("org.springframework", "spring-web", "3.0.4.RELEASE"), self.new("com.thoughtworks.xstream", "xstream", "1.3.1")]
  end

  def self.test_scope
    [self.new("junit", "junit", "4.8.2"), 
      self.new("org.hamcrest", "hamcrest-all", "1.1"),
      self.new("org.mockito", "mockito-all", "1.8.5")]
  end

  def self.provided_scope
    [self.new("javax.servlet", "servlet-api", "2.5")]
  end

  def has_exclusions?
    !@exclusions.empty?
  end
end
