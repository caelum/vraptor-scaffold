#!/usr/bin/env rake
require "bundler/gem_tasks"

@integration = ENV["i"]
require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList.new('spec/**/*_spec.rb') do |fl|
    if not @integration
      fl.exclude(/.*integration_spec\.rb/)
    end
  end
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
