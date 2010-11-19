require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "vraptor-scaffold"
    gem.summary = "VRaptor Scaffold."
    gem.description = "VRaptor scaffold extension to make it easier configuring new projects and plugins."
    gem.email = "rodolfoliviero@gmail.com"
    gem.homepage = "http://github.com/caelum/vraptor-scaffold"
    gem.authors = ["Rodolfo Liviero"]
    gem.add_dependency "thor", "0.14.4"
    gem.add_dependency "rake", "0.8.7"
    gem.add_dependency "activesupport", "3.0.1"
    gem.post_install_message = "Thank you for installing vraptor-scaffold. Please read http://github.com/caelum/vraptor-scaffold/blob/master/README.textile for more information."
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.spec_files = FileList['spec/**/*_spec.rb']
  spec.rcov_opts = ['--exclude', 'spec/*,gems/*']
  spec.rcov = true
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "vraptor-scaffold #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :spec => :check_dependencies
task :default => [:spec]
