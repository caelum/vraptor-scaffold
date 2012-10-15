require "spec_helper"

describe VraptorScaffold::Execution do

  before(:each) do
    @execution = VraptorScaffold::Execution.new
  end

  context "discover runner for action" do
    it "should be commands help when no action" do
      @execution.runner_for(nil).should == VraptorScaffold::Runner::CommandsHelp
    end

    it "should be app generator when help action" do
      @execution.runner_for("any").should == VraptorScaffold::Runner::CommandsHelp
    end

    it "should be app generator when new action" do
      @execution.runner_for("new").should == VraptorScaffold::Runner::Generator
    end

    it "should be app generator when scaffold action" do
      @execution.runner_for("scaffold").should == VraptorScaffold::Runner::Scaffold
    end

    it "should be plugin generator when plugin action" do
      @execution.runner_for("plugin").should == VraptorScaffold::Runner::Plugin
    end

    it "should be contrib when contrib action" do
      @execution.runner_for("contrib").should == VraptorScaffold::Runner::Contrib
    end

    it "should be start application when start action" do
      @execution.runner_for("start").should == VraptorScaffold::Runner::Start
    end

    it "should be commands help when scaffold when unknown action" do
      @execution.runner_for("xpto").should == VraptorScaffold::Runner::CommandsHelp
    end
  end

  it "should discover runner and run" do
    runner = mock(VraptorScaffold::Runner::Generator)
    runner.stub!(:new).and_return runner
    runner.should_receive(:run).with(['app'])
    @execution.stub!(:runner_for).with('new').and_return(runner)
    @execution.run(['new', 'app'])
  end

  it "should call a runner help" do
    runner = mock(VraptorScaffold::Runner::Scaffold)
    runner.stub!(:new).and_return runner
    runner.should_receive(:run).with(['-h'])
    @execution.stub!(:runner_for).with('scaffold').and_return(runner)
    @execution.run(['help', 'scaffold'])
  end

end
