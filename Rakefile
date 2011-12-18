#!/usr/bin/env rake
require "bundler/gem_tasks"

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = VraptorScaffold::VERSION

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "vraptor-scaffold #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

task :default => [:spec]
