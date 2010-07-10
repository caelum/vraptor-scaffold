require 'spec'
require 'spec/autorun'
require File.dirname(__FILE__) + '/../lib/vraptor-scaffold'

def build_attributes
	attributes = [Attribute.new("name", "string"), Attribute.new("value", "double")]
end
