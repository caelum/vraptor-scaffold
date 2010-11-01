class DependencyManager
  
  attr_accessor :options
  
  def initialize(options)
    @options = options
  end
 
  def compile_scope
    dependencies = []
    if options[:spring_version] == "3.0"
      dependencies << Dependency.new("br.com.caelum", "vraptor", "3.2.0",[Dependency.new("org.springframework", "spring")])
      dependencies = dependencies + compile_scope_default_libs + compile_scope_spring3_libs
    else
      dependencies << Dependency.new("br.com.caelum", "vraptor", "3.2.0") 
      dependencies = dependencies + compile_scope_default_libs
    end
    dependencies << Dependency.new("org.freemarker", "freemarker", "2.3.16") if @options[:template_engine] == 'ftl'
    dependencies
  end

  def compile_scope_default_libs
    [ Dependency.new("org.hsqldb", "hsqldb", "2.0.0"),
        Dependency.new("opensymphony", "sitemesh", "2.4.2"), Dependency.new("javax.servlet", "jstl", "1.2"),
        Dependency.new("javax.persistence", "persistence-api", "1.0"), 
        Dependency.new("org.hibernate", "hibernate-entitymanager", "3.4.0.GA"),
        Dependency.new("org.hibernate", "hibernate-core", "3.3.2.GA"),
        Dependency.new("org.hibernate", "hibernate-validator", "3.1.0.GA"),
        Dependency.new("joda-time", "joda-time", "1.6")]
  end

  def compile_scope_spring3_libs
    [Dependency.new("org.springframework", "spring-web", "3.0.4.RELEASE"), Dependency.new("com.thoughtworks.xstream", "xstream", "1.3.1")]
  end

  def test_scope
    [Dependency.new("junit", "junit", "4.8.2"), 
      Dependency.new("org.hamcrest", "hamcrest-all", "1.1"),
      Dependency.new("org.mockito", "mockito-all", "1.8.5")]
  end

  def provided_scope
    [Dependency.new("javax.servlet", "servlet-api", "2.5")]
  end
end
