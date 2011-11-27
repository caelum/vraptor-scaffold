require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe ImportManager do
  
  it "should import package java.math.BigDecimal when type is BigDecimal" do
    ImportManager.new("big_decimal").package.include?("java.math.BigDecimal").should be_true
  end

  it "should import package java.math.BigInteger when type is BigInteger" do
    ImportManager.new("big_integer").package.include?("java.math.BigInteger").should be_true
  end

  it "should import package java.util.Date when type is Date" do
    ImportManager.new("date").package.include?("java.util.Date").should be_true
  end

  it "should import package org.joda.time.LocalDate when type is LocalDate" do
    ImportManager.new("local_date").package.include?("org.joda.time.LocalDate").should be_true
  end

  it "should import package org.joda.time.LocalDateTime when type is LocalDateTime" do
    ImportManager.new("local_date_time").package.include?("org.joda.time.LocalDateTime").should be_true
  end

  it "should import package org.joda.time.LocalTime when type is LocalTime" do
    ImportManager.new("local_time").package.include?("org.joda.time.LocalTime").should be_true
  end

  it "should import package javax.persistence.ManyToOne when relationship is many to one" do
    ImportManager.new("references").package.include?("javax.persistence.ManyToOne").should be_true
  end    
  
end