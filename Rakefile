require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "vraptor-scaffold"
    gem.summary = "Scaffold for vraptor 3."
    gem.description = ""
    gem.email = "rodolfoliviero@gmail.com"
    gem.homepage = "http://github.com/rodolfoliviero/vraptor-scaffold"
    gem.authors = ["Rodolfo Liviero"]
  	gem.post_install_message = "Thank you for installing vraptor-scaffold. Please read http://github.com/rodolfoliviero/vraptor-scaffold/blob/master/README.rdoc for more information."
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

task :spec => :check_dependencies
task :default => [:spec]
