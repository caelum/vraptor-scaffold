require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe Attribute do

  context "getter method prefix" do
    it "should be 'is' to boolean attributes" do
      Attribute.new("active", "boolean").getter_prefix.should == "is"
    end

    it "should be 'get' otherwise" do
      Attribute.new("description", "string").getter_prefix.should == "get"
    end
  end

  context "initialize attribute" do
    context "downcase name" do
      it "should downcase all words" do
        Attribute.new("VALUE", "double").name.should == "value"
      end

      it "should camelize composed name" do
        Attribute.new("MyItem", "double").name.should == "myItem"
      end

      it "should camelize composed name" do
        Attribute.new("myItem", "double").name.should == "myItem"
      end

      it "should keep name in downcase" do
        Attribute.new("value", "double").name.should == "value"
      end
    end

    it "should downcase type" do
      Attribute.new("value", "DoublE").type.should == "double"
    end
  end

  context "supported types" do
    it "should support boolean" do
      Attribute.valid_types.include?("boolean").should be_true
    end

    it "should support double" do
      Attribute.valid_types.include?("double").should be_true
    end

    it "should support string" do
      Attribute.valid_types.include?("string").should be_true
    end

    it "should support float" do
      Attribute.valid_types.include?("float").should be_true
    end

    it "should support short" do
      Attribute.valid_types.include?("short").should be_true
    end

    it "should support integer" do
      Attribute.valid_types.include?("integer").should be_true
    end

    it "should support long" do
      Attribute.valid_types.include?("long").should be_true
    end

    it "should support text" do
      Attribute.valid_types.include?("text").should be_true
    end

    it "should not support other" do
      Attribute.valid_types.include?("other").should be_false
    end

    it "should suport big decimal" do
      Attribute.valid_types.include?("big_decimal").should be_true
    end

    it "should suport date" do
      Attribute.valid_types.include?("date").should be_true
    end

    it "should suport LocalDate" do
      Attribute.valid_types.include?("local_date").should be_true
    end

    it "should suport LocalDateTime" do
      Attribute.valid_types.include?("local_date_time").should be_true
    end

    it "should suport LocalTime" do
      Attribute.valid_types.include?("local_time").should be_true
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

    it "should know html input to text" do
      Attribute.new("name", "text").html_input.should eql("textarea")
    end

    it "should know html input to big decimal" do
      Attribute.new("price", "big_decimal").html_input.should eql("text")
    end

    it "should know html input to big integer" do
      Attribute.new("price", "big_integer").html_input.should eql("text")
    end

    it "should know html input to date" do
      Attribute.new("price", "date").html_input.should eql("text")
    end

    it "should know html input to LocalDate" do
      Attribute.new("price", "local_date").html_input.should eql("text")
    end

    it "should know html input to LocalTime" do
      Attribute.new("price", "local_time").html_input.should eql("text")
    end

    it "should know html input to LocalDateTime" do
      Attribute.new("price", "local_date_time").html_input.should eql("text")
    end

  end

  context "java type" do
    it "should know correct java type to boolean" do
      Attribute.new("flag", "boolean").java_type.should eql("boolean")
    end

    it "should know correct java type to text" do
      Attribute.new("description", "text").java_type.should eql("String")
    end

    it "should know correct java type to string" do
      Attribute.new("name", "string").java_type.should eql("String")
    end

    it "should know correct java type to double" do
      Attribute.new("name", "double").java_type.should eql("Double")
    end

    it "should know correct java type to float" do
      Attribute.new("name", "float").java_type.should eql("Float")
    end

    it "should know correct java type to short" do
      Attribute.new("name", "short").java_type.should eql("Short")
    end

    it "should know correct java type to integer" do
      Attribute.new("name", "integer").java_type.should eql("Integer")
    end

    it "should know correct java type to long" do
      Attribute.new("name", "long").java_type.should eql("Long")
    end

    it "should know correct java type to BigDecimal" do
      Attribute.new("price", "big_decimal").java_type.should eql("BigDecimal")
    end

    it "should know correct java type to BigInteger" do
      Attribute.new("price", "big_integer").java_type.should eql("BigInteger")
    end

    it "should know correct java type to Date" do
      Attribute.new("price", "date").java_type.should eql("Date")
    end

    it "should know correct java type to LocalDate" do
      Attribute.new("price", "local_date").java_type.should eql("LocalDate")
    end

    it "should know correct java type to LocalTime" do
      Attribute.new("price", "local_time").java_type.should eql("LocalTime")
    end

    it "should know correct java type to LocalDateTime" do
      Attribute.new("price", "local_date_time").java_type.should eql("LocalDateTime")
    end

    it "should know correct type to relationship many to one" do
      Attribute.new("product", "references").java_type.should eql("Product")
    end

  end

  context "validate" do

    it "should be valid when attribute is supported" do
      Kernel.should_not_receive(:exit)
      Attribute.valid_types.each do |type|
        Attribute.new("name", type)
      end
    end

    it "cannot be valid when attribute is not supported" do
      Kernel.should_receive(:exit)
      Attribute.new("name", "char")
    end

    it "should be valid when attribute is upper case" do
      Kernel.should_not_receive(:exit)
      Attribute.new("name", "String")
    end
  end

  it "should be boolean when type is boolean" do
    Attribute.new("flag", "boolean").boolean?.should be_true
  end

  it "cannot be boolean otherwise" do
    Attribute.new("flag", "short").boolean?.should be_false
  end

  context "html label" do
    it "should humanize composed name" do
      Attribute.new("MyItem", "double").html_label.should == "My item"
    end

    it "should humanize composed name" do
      Attribute.new("myItem", "double").html_label.should == "My item"
    end

    it "should humanize single name" do
      Attribute.new("item", "double").html_label.should == "Item"
    end
  end
end
