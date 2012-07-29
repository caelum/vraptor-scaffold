class DefaultDependencies

  attr_accessor :options

  def initialize(options)
	  @options = options
  end

  def compile_scope
    dependencies = append_freemarker_dependency_if_necessary default_dependencies
    dependencies
  end

  def test_scope
    [Dependency.new("junit", "junit", "4.10"),
     Dependency.new("org.hamcrest", "hamcrest-all", "1.1"),
     Dependency.new("org.mockito", "mockito-all", "1.9.0")]
  end

  def provided_scope
    [Dependency.new("javax.servlet", "servlet-api", "2.5"), Dependency.new("javax.servlet.jsp", "jsp-api", "2.1")]
  end

  private
  def default_dependencies
		hibernate_version = "4.0.1.Final"
		dependencies = [Dependency.new("br.com.caelum", "vraptor", "3.4.1"),
									Dependency.new("opensymphony", "sitemesh", "2.4.2"),
									Dependency.new("javax.servlet", "jstl", "1.2"),
									Dependency.new("org.hsqldb", "hsqldb", "2.2.8"),
									Dependency.new("org.hibernate", "hibernate-entitymanager", hibernate_version),
									Dependency.new("org.hibernate", "hibernate-c3p0", hibernate_version),
									Dependency.new("org.hibernate", "hibernate-validator", "4.2.0.Final"),
									Dependency.new("joda-time", "joda-time", "2.0"),
									Dependency.new("com.thoughtworks.xstream", "xstream", "1.4.1")]

    dependencies
  end

  def append_freemarker_dependency_if_necessary dependencies
    dependencies << Dependency.new("org.freemarker", "freemarker", "2.3.18") if @options[:template_engine] == 'ftl'
    dependencies
  end
end
