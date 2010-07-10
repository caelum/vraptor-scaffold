require 'spec'
require 'spec/autorun'
require File.dirname(__FILE__) + '/../lib/vraptor-scaffold'

def build_attributes
	[Attribute.new("name", "string"), Attribute.new("flag", "boolean")]
end
