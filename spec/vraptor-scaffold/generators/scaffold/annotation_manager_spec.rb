require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe AnnotationManager do
  
  it "should know annotation when relationship is many to one" do
    AnnotationManager.new("references").annotation.include?("ManyToOne").should be_true
  end   

  it "should know annotation when type is local date" do
    AnnotationManager.new("local_date").annotation.include?("Type(type=\"org.joda.time.contrib.hibernate.PersistentLocalDate\")").should be_true
  end   

  it "should know annotation when type is local time" do
    AnnotationManager.new("local_time").annotation.include?("Type(type=\"org.joda.time.contrib.hibernate.PersistentLocalTimeAsTime\")").should be_true
  end   

  it "should know annotation when type is local date time" do
    AnnotationManager.new("local_date_time").annotation.include?("Type(type=\"org.joda.time.contrib.hibernate.PersistentLocalDateTime\")").should be_true
  end   
    
end