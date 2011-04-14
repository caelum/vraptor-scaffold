require "spec_helper"

describe VraptorScaffold::Runner::Scaffold do

  before(:all) do
    @help = VraptorScaffold::Runner::Help
    @scaffold_runner = VraptorScaffold::Runner::Scaffold
  end

  it "should print help command" do
    @help.stub!(:help).with("--help").and_return true
    ScaffoldGenerator.should_receive(:start).with(["-h"])
    @scaffold_runner.new.run(["--help"])
  end

  context "scaffold generator" do
    before(:each) do
      @generator = mock(ScaffoldGenerator)
      @args = ["product", "name:string", "value:double"]
    end

    it "should invoke all scaffold generator tasks" do
      File.stub!(:exist?).and_return(true)
      ScaffoldGenerator.stub!(:new).with(@args).and_return(@generator)
      @generator.should_receive(:invoke_all)
      @scaffold_runner.new.run(@args)
    end

    it "cannot invoke scaffold generator outsite root folder" do
      File.stub!(:exist?).and_return(false)
      ScaffoldGenerator.should_not_receive(:new)
      @scaffold_runner.new.run(@args)
    end
  end
end