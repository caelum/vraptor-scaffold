require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe ContribInstaller do

  before :each do
  end

  it "should configure banner" do
    ContribInstaller.banner.should == "vraptor contrib install contrib_name"
  end

  context "finding contrib into maven official repo" do

    before :each do
      AppGenerator.new("mvn_project", ["-b=mvn", "--skip-jquery"]).invoke_all
      FileUtils.chdir("mvn_project")
    end

    after :each do
      FileUtils.chdir("..")
      FileUtils.rm_rf("mvn_project")
    end

    it "should exit contrib installation when outside root folder" do
      File.stub(:exist?).and_return(false)
      Kernel.should_receive(:puts).with("To run 'vraptor contrib install' please go to the project root folder.")
      Kernel.should_receive(:exit)

      ContribInstaller.new("vraptor-authz").invoke_all
    end
  end

end
