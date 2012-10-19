require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe ContribInstaller do

  before :each do
  end

  it "should configure banner" do
    ContribInstaller.banner.should == "vraptor contrib install contrib_name"
  end

  it "should validate when not in root folder" do
      File.stub(:exist?).with("src").and_return(false)
      Kernel.should_receive(:puts).with("To run 'vraptor contrib install' please go to the project root folder.")

      lambda { ContribInstaller.new("vraptor-authz").invoke_all }.should raise_error(SystemExit)
  end

  context "found contrib into maven official repo" do

    before :each do
      AppGenerator.new("mvn_project", ["-b=mvn", "--skip-jquery"]).invoke_all
      FileUtils.chdir("mvn_project")
    end

    after :each do
      FileUtils.chdir("..")
      FileUtils.rm_rf("mvn_project")
    end

    it "should inject a contrib into build configuration file" do
      check_file("pom.xml", "vraptor-authz").should be_false
      ContribInstaller.new("vraptor-authz").invoke_all
      check_file("pom.xml", "vraptor-authz").should be_true
    end
  end

  context "not found contrib into maven official repo," do

    before :each do
      AppGenerator.new("project", ["--skip-jquery"]).invoke_all
      FileUtils.chdir("project")
    end

    after :each do
      FileUtils.chdir("..")
      FileUtils.rm_rf("project")
    end

    it "should download vraptor-contrib file if not exists" do
      contrib_name = "vraptor-cep"
      check_file("ivy.xml", contrib_name).should be_false

      ContribInstaller.new(contrib_name).invoke_all
    end
  end
end
