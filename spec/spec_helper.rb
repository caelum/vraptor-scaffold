require 'spec'
require 'spec/autorun'
require File.dirname(__FILE__) + '/../lib/vraptor-scaffold'

def build_attributes
  [Attribute.new("name", "string"), Attribute.new("flag", "boolean")]
end

def mock_config_file
  file = YAML.load_file File.join( File.dirname(__FILE__), "resources", "vraptor-scaffold.properties")
  Configuration.stub!(:config).and_return(file)
end
