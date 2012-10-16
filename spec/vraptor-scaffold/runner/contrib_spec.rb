require "spec_helper"

describe VraptorScaffold::Runner::Contrib do

  before(:all) do
    @help = VraptorScaffold::Runner::Help
    @contrib_runner = VraptorScaffold::Runner::Contrib
    @contrib_installer = mock(ContribInstaller)
    @contrib_list = mock(ContribList)
    File.stub!(:exist?).with("src").and_return(true)
  end

  context "contrib runner" do
    it "cannot invoke plugin generator outsite root folder" do
      File.stub!(:exist?).with("src").and_return(false)
      lambda { @contrib_runner.new.run(["list"]) }.should raise_error(SystemExit)
    end
  end

  context "contribs list" do
    it "should be downloaded if not exists" do
      ContribList.should_receive(:new).and_return(@contrib_list)
      @contrib_list.should_receive(:invoke_all)
      @contrib_runner.new.run(["list"])
    end
  end

  context "contrib install" do
    it "should call contrib installer" do
      ContribInstaller.should_receive(:new).and_return(@contrib_installer)
      @contrib_installer.should_receive(:invoke_all)

      @contrib_runner.new.run(["install", "contrib_name"])
    end
  end
end
