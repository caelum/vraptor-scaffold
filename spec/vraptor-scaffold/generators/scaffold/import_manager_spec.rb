require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe ImportManager do

  it "should import package when type is Date" do
    ImportManager.new("date").package.include?("java.util.Date").should be_true
  end

end
