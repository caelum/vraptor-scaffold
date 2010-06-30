Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'vraptor-scaffold'
  s.homepage	= 'http://github.com/rodolfoliviero/vraptor-scaffold'
  s.version     = '0.0.1'
  s.summary     = 'Scaffold for vraptor 3.'
  s.description = ''

  s.required_ruby_version     = '>= 1.8.7'
  s.required_rubygems_version = ">= 1.3.6"

  s.author            = 'Rodolfo Liviero'
  s.email             = 'rodolfoliviero@gmail.com'

  s.extra_rdoc_files = ['README.rdoc']

  s.bindir             = 'bin'
  s.executables        = ['vraptor']
  
  s.files = [
     "Gemfile",
     "Rakefile",
     "lib/load_paths.rb",
     "lib/vraptor-scaffold.rb",
     "lib/generators/app_generator.rb",
     "lib/generators/templates/decorators.xml",
     "lib/generators/templates/FreemarkerPathResolver.java",
     "lib/generators/templates/index.jsp",
     "lib/generators/templates/log4j.xml",
     "lib/generators/templates/main.ftl",
     "lib/generators/templates/persistence.xml",
     "lib/generators/templates/pom.erb",
     "lib/generators/templates/web.xml"
  ]
end
