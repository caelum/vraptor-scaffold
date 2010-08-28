require 'rubygems'

require 'thor/actions'
require 'thor/group'
require 'active_support/inflector'

require File.dirname(__FILE__) + '/configuration'
require File.dirname(__FILE__) + '/../lib/generators/base'
require File.dirname(__FILE__) + '/../lib/generators/app_generator/app_generator'
require File.dirname(__FILE__) + '/../lib/generators/scaffold_generator/attribute'
require File.dirname(__FILE__) + '/../lib/generators/scaffold_generator/scaffold_generator'
require File.dirname(__FILE__) + '/../lib/generators/scaffold_generator/base_scaffold'
require File.dirname(__FILE__) + '/../lib/generators/scaffold_generator/model_generator/model_generator'
require File.dirname(__FILE__) + '/../lib/generators/scaffold_generator/repository_generator/repository_generator'
require File.dirname(__FILE__) + '/../lib/generators/scaffold_generator/controller_generator/controller_generator'
require File.dirname(__FILE__) + '/../lib/generators/scaffold_generator/freemarker_generator/freemarker_generator'

