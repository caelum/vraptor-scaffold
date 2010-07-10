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
  
end
