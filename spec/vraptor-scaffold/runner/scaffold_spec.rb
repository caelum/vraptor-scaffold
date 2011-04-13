require "spec_helper"

describe VraptorScaffold::Runner::Scaffold do
  
  context "scaffold generator help" do
    before(:each) do
      File.stub!(:exist?).and_return(true)
      generator = mock(ScaffoldGenerator)
      generator.stub!(:invoke_all)
      ScaffoldGenerator.stub!(:new).and_return(generator)
      ScaffoldGenerator.should_receive(:start).with(["-h"])
    end

    it "should print help when vraptor scaffold" do
      VraptorScaffold::Execution.new.run(["scaffold"])
    end

    it "should print help when vraptor scaffold -h" do
      VraptorScaffold::Execution.new.run(["scaffold", "-h"])
    end

    it "should print help when vraptor scaffold --help" do
      VraptorScaffold::Execution.new.run(["scaffold", "--help"])
    end
  end

  context "scaffold generator" do
    before(:each) do
      @generator = mock(ScaffoldGenerator)
      @args = ["scaffold", "product", "name:string", "value:double"]
      ScaffoldGenerator.stub!(:new).with(@args).and_return(@generator)
    end

    it "should invoke all scaffold generator tasks" do
      File.stub!(:exist?).and_return(true)
      @generator.should_receive(:invoke_all)
      VraptorScaffold::Execution.new.run(@args)
    end

    it "cannot invoke scaffold generator outsite root folder" do
      File.stub!(:exist?).and_return(false)
      @generator.stub!(:invoke_all)
      VraptorScaffold::Execution.new.run(@args)
    end
  end
end