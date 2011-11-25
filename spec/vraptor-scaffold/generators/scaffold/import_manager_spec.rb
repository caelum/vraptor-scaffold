require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe ImportManager do
  
  it "should import package java.math.BigDecimal when type is BigDecimal" do
    ImportManager.new("big_decimal").package.include? "java.math.BigDecimal"
  end

  it "should import package javax.persistence.ManyToOne when relationship is many to one" do
    ImportManager.new("references").package.include?("javax.persistence.ManyToOne").should be_true
  end    
  
end