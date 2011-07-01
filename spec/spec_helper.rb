require 'spec'
require 'spec/autorun'
require File.dirname(__FILE__) + '/../lib/vraptor-scaffold'

def build_attributes
  [Attribute.new("name", "string"), Attribute.new("myFlag", "boolean")]
end

def mock_config_file
  file = YAML.load_file File.join( File.dirname(__FILE__), "resources", "vraptor-scaffold.properties")
  Configuration.stub!(:config).and_return(file)
end

def exists_and_identical?(source, created)
  File.exists?(created).should be_true
  if(!FileUtils.identical?(source, created))
    puts "----------$$--------$$----------"
    IO.readlines(created).each do |l|
      puts l
    end
    puts "----------$$--------$$----------"
    IO.readlines(source).each do |l|
      puts l
    end
    puts "----------$$--------$$----------"
    FileUtils.should be_identical(source, created)
  end
end
