require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe ContribList do

  context "contrib list" do

    before(:each) do
    end

    it "should have a banner" do
      ContribList.banner == "vraptor contrib list"
    end

    it "should known that address type is url" do
      File.stub!(:exists?).and_return(true)
      File.stub!(:readlines).and_return(["vraptor-authz: git://github.com/qmx/vraptor-authz.git"])

      ContribList.which_address_type_to_plugin("vraptor-authz").should eql(:url)
    end

    it "should known that address type is ssh" do
      File.stub!(:exists?).and_return(true)
      File.stub!(:readlines).and_return(["vraptor-test: git@github.com:caelum/vraptor-test.git"])

      ContribList.which_address_type_to_plugin("vraptor-test").should eql(:ssh)
    end

    it "should unknown the address" do
      File.stub!(:exists?).and_return(true)
      File.stub!(:readlines).and_return(["vraptor-test: my.fake.url"])

      ContribList.which_address_type_to_plugin("vraptor-test").should eql(:unkown)
    end

    it "should download contrib list available" do
      ContribList.new("list").invoke_all
      File.exists?('.vraptor-contrib').should be_true
      FileUtils.rm('.vraptor-contrib')
    end
  end
end
