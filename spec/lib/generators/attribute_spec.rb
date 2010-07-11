require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")

describe Attribute do
  
  context "supported types" do
    it "should support boolean" do
      Attribute.valid_types.include?"boolean".should be_true
    end
    
    it "should support double" do
      Attribute.valid_types.include?"double".should be_true
    end
    
    it "should support string" do
      Attribute.valid_types.include?"string".should be_true
    end
    
    it "should support float" do
      Attribute.valid_types.include?"float".should be_true
    end
    
    it "should support short" do
      Attribute.valid_types.include?"short".should be_true
    end
    
    it "should support integer" do
      Attribute.valid_types.include?"integer".should be_true
    end
    
    it "should support long" do
      Attribute.valid_types.include?"long".should be_true
    end
  end
  
  context "html_input" do
    it "should know html input to boolean" do
      Attribute.new("flag", "boolean").html_input.should eql("checkbox")
    end
    
    it "should know html input to string" do
      Attribute.new("name", "string").html_input.should eql("text")
    end
    
    it "should know html input to double" do
      Attribute.new("name", "double").html_input.should eql("text")
    end
    
    it "should know html input to float" do
      Attribute.new("name", "float").html_input.should eql("text")
    end
    
    it "should know html input to short" do
      Attribute.new("name", "short").html_input.should eql("text")
    end
    
    it "should know html input to integer" do
      Attribute.new("name", "integer").html_input.should eql("text")
    end
    
    it "should know html input to long" do
      Attribute.new("name", "long").html_input.should eql("text")
    end
  end
  
   context "set type" do
    it "should set corret type to boolean" do
      Attribute.new("flag", "boolean").type.should eql("boolean")
    end
    
     it "should set corret type otherwise" do
      Attribute.new("id", "long").type.should eql("Long")
    end
  end
  
  it "should be boolean when type is boolean" do
    Attribute.new("flag", "boolean").boolean?.should be_true
  end
  
  it "cannot be boolean otherwise" do
    Attribute.new("flag", "short").boolean?.should be_false
  end
end
