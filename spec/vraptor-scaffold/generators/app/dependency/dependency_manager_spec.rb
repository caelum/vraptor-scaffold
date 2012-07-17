require File.expand_path(File.dirname(__FILE__) + "/../../../../spec_helper")

describe DependencyManager do

	context "dependencies by project type" do
		it "should be default" do
			options = {}
			DependencyManager.new(options).dependencies.class.should == DefaultDependencies
		end

		it "should be heroku" do
			options = {:heroku => true}
			DependencyManager.new(options).dependencies.class.should == HerokuDependencies
		end

		it "should be gae" do
			options = {:gae => true}
			DependencyManager.new(options).dependencies.class.should == GaeDependencies
		end
	end
end
