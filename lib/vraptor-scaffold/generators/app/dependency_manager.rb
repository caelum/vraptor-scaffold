class DependencyManager

  attr_accessor :options

  def initialize(options)
    @options = options
  end

  def compile_scope
    dependencies = append_freemarker_dependency_if_necessary default_dependencies
    dependencies = append_heroku_dependencies_if_necessary dependencies
    dependencies = append_gae_dependencies_if_necessary dependencies
    dependencies
  end

  def test_scope
    [Dependency.new("junit", "junit", "4.10"),
     Dependency.new("org.hamcrest", "hamcrest-all", "1.1"),
     Dependency.new("org.mockito", "mockito-all", "1.8.5")]
  end

  def provided_scope
    if @options[:heroku]
      return []
    end
    [Dependency.new("javax.servlet", "servlet-api", "2.5"), Dependency.new("javax.servlet.jsp", "jsp-api", "2.1")]
  end

  private
  def default_dependencies
    dependencies = [Dependency.new("br.com.caelum", "vraptor", "3.4.0"),
                    Dependency.new("opensymphony", "sitemesh", "2.4.2"), 
                    Dependency.new("javax.servlet", "jstl", "1.2")]

    if !@options[:gae]
      hibernate_version = "3.6.7.Final"
      dependencies += [Dependency.new("org.hsqldb", "hsqldb", "2.2.4"),
                       Dependency.new("org.hibernate", "hibernate-entitymanager", hibernate_version),
                       Dependency.new("org.hibernate", "hibernate-c3p0", hibernate_version)]
    end

    dependencies += [Dependency.new("org.hibernate", "hibernate-validator", "4.2.0.Final"),
                     Dependency.new("joda-time", "joda-time", "2.0"),
                     Dependency.new("com.thoughtworks.xstream", "xstream", "1.4.1")]
    dependencies
  end

  def append_heroku_dependencies_if_necessary dependencies
    if @options[:heroku]
      dependencies += [Dependency.new("org.eclipse.jetty", "jetty-webapp", "7.4.4.v20110707"),
                       Dependency.new("org.mortbay.jetty", "jsp-2.1-glassfish", "2.1.v20100127"),
                       Dependency.new("javax.servlet", "servlet-api", "2.5")]
    end
    dependencies
  end

  def append_gae_dependencies_if_necessary dependencies
    if @options[:gae]
      dependencies += [Dependency.new("com.googlecode.objectify", "objectify", "2.2.3")]
    end
    dependencies
  end

  def append_freemarker_dependency_if_necessary dependencies
    dependencies << Dependency.new("org.freemarker", "freemarker", "2.3.18") if @options[:template_engine] == 'ftl'
    dependencies
  end
end
