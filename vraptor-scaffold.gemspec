# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "vraptor-scaffold/version"

Gem::Specification.new do |s|
  s.name        = "vraptor-scaffold"
  s.version     = VraptorScaffold::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Rodolfo Liviero"]
  s.email       = "rodolfoliviero@gmail.com"
  s.homepage    = "http://github.com/caelum/vraptor-scaffold"
  s.summary     = "VRaptor Scaffold."
  s.description = "VRaptor scaffold extension to make it easier configuring new projects and plugins."
  s.post_install_message = "Thank you for installing vraptor-scaffold. Please read http://github.com/caelum/vraptor-scaffold/blob/master/README.textile for more information."
  
  s.add_dependency('thor', '0.14.6')
  s.add_dependency('activesupport', "~> 3.0.9")
  s.add_dependency('rake', '0.8.7')
  s.add_dependency('i18n', '0.6.0')

  s.add_development_dependency('rspec', '1.3.2')
  s.add_development_dependency('ZenTest', '4.4.0')
  s.add_development_dependency('rcov', '0.9.9')

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {spec}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
