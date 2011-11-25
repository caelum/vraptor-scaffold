require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe AnnotationManager do
  
  it "should know annotation when relationship is many to one" do
    AnnotationManager.new("references").annotation.include?("ManyToOne")
  end   
    
end