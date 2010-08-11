require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe BaseScaffold do

	before(:each) do
   		@base = BaseScaffold.new("client")
 	end	
	  
	it "should know class name" do
		@base.class_name.should eql("Client")
	end
	
	it "should know repository class name" do
		@base.repository_class_name.should eql("ClientRepository")
	end
	
	it "should know controller class name" do
		@base.controller_class_name.should eql("ClientController")
	end
end
