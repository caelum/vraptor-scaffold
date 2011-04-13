require "spec_helper"

describe VraptorScaffold::Runner::Generator do

  context "app generator help" do
    before(:each) do
      generator = mock(AppGenerator)
      generator.stub!(:invoke_all)
      AppGenerator.stub!(:new).and_return(generator)
      AppGenerator.should_receive(:start).with(["-h"])
    end

    it "should print help when vraptor" do
      VraptorScaffold::Execution.new.run([])
    end

    it "should print help when vraptor -h" do
      VraptorScaffold::Execution.new.run(["-h"])
    end

    it "should print help when vraptor --help" do
      VraptorScaffold::Execution.new.run(["--help"])
    end

    it "should print help when vraptor new" do
      VraptorScaffold::Execution.new.run(["new"])
    end

    it "should print help when vraptor new -h" do
      VraptorScaffold::Execution.new.run(["new", "-h"])
    end

    it "should print help when vraptor new --help" do
      VraptorScaffold::Execution.new.run(["new", "--help"])
    end
  end

  context "app generator" do
    before(:each) do
      @generator = mock(AppGenerator)
      project_name = "vraptor-scaffold"
      option = "--package=br.com.caelum"
      @args = ["new", project_name, option]
      AppGenerator.stub!(:new).with(project_name, [option]).and_return(@generator)
    end

    it "should invoke all app generator tasks when typed new" do
      @generator.should_receive(:invoke_all)
      VraptorScaffold::Execution.new.run(@args)
    end
  end
end