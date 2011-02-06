class DependencyManager
  
  attr_accessor :options
  
  def initialize(options)
    @options = options
  end
 
  def compile_scope
    append_freemarker_dependency_if_necessary default_dependencies
  end
  
  def test_scope
    [Dependency.new("junit", "junit", "4.8.2"), 
      Dependency.new("org.hamcrest", "hamcrest-all", "1.1"),
      Dependency.new("org.mockito", "mockito-all", "1.8.5")]
  end

  def provided_scope
    [Dependency.new("javax.servlet", "servlet-api", "2.5"), Dependency.new("javax.servlet.jsp", "jsp-api", "2.1")]
  end
  
  private
  def default_dependencies
    [ Dependency.new("br.com.caelum", "vraptor", "3.3.0"),
        Dependency.new("net.sf.scannotation", "scannotation", "1.0.2"), Dependency.new("org.hsqldb", "hsqldb", "2.0.0"),
        Dependency.new("opensymphony", "sitemesh", "2.4.2"), Dependency.new("javax.servlet", "jstl", "1.2"),
        Dependency.new("org.hibernate", "hibernate-entitymanager", "3.6.1.Final"),
        Dependency.new("org.hibernate", "hibernate-validator", "4.1.0.Final"),
        Dependency.new("joda-time", "joda-time", "1.6.2")]
  end
  
  def append_freemarker_dependency_if_necessary dependencies
     dependencies << Dependency.new("org.freemarker", "freemarker", "2.3.16") if @options[:template_engine] == 'ftl'
     dependencies
  end
end