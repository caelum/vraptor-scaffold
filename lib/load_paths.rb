require 'rubygems'
require "bundler"
#Bundler.setup
require 'thor/actions'
require 'thor/group'
require 'active_support/inflector'

require File.dirname(__FILE__) + '/../lib/generators/app_generator'
require File.dirname(__FILE__) + '/../lib/generators/scaffold_generator'
require File.dirname(__FILE__) + '/../lib/generators/attribute'
