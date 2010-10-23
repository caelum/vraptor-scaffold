class Dependency

  attr_accessor :group, :name, :version

  def initialize group, name, version
    @group = group
    @name = name
    @version = version
  end

  def self.compile_scope
    [self.new("br.com.caelum", "vraptor", "3.2.0"), self.new("hsqldb", "hsqldb", "1.8.0.10"),
      self.new("opensymphony", "sitemesh", "2.4.2"), self.new("javax.servlet", "jstl", "1.2"),
      self.new("javax.persistence", "persistence-api", "1.0"), 
      self.new("org.hibernate", "hibernate-entitymanager", "3.4.0.GA"),
      self.new("org.hibernate", "hibernate-core", "3.3.2.GA"),
      self.new("org.hibernate", "hibernate-validator", "3.1.0.GA"),
      self.new("joda-time", "joda-time", "1.6")]
  end

  def self.spring_3_compile_scope
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
end
