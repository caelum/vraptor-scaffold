require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe BaseScaffold do

  before(:each) do
    @base = BaseScaffold.new("client")
  end	

  it "should know model class name" do
    @base.class_name.should eql("Client")
  end

  it "should know model test class name" do
    @base.test_class_name.should eql("ClientTest")
  end

  it "should know repository class name impl" do
    @base.repository_impl_name.should eql("ClientRepositoryImpl")
  end

  it "should know repository interface name" do
    @base.repository_interface_name.should eql("ClientRepository")
  end

  it "should know repository test class name" do
    @base.repository_test_class_name.should eql("ClientRepositoryImplTest")
  end

  it "should know controller class name" do
    @base.controller_class_name.should eql("ClientController")
  end

  it "should know controller test class name" do
    @base.controller_test_class_name.should eql("ClientControllerTest")
  end
  
  it "should know model parameter name with scaffold given with first letter uppercased" do
    base = BaseScaffold.new("Client")
    base.model_parameter_name.should eql("client")
  end
end