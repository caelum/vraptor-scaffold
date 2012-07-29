require "spec_helper"

describe VraptorScaffold::Runner::Generator do

  before(:all) do
    @help = VraptorScaffold::Runner::Help
    @generator_runner =  VraptorScaffold::Runner::Generator
  end

  it "should print help command" do
    @help.stub!(:help).with("--help").and_return true
    AppGenerator.should_receive(:start).with(["-h"])
    @generator_runner.new.run(["--help"])
  end

  context "default app generator" do
    before(:each) do
      @generator = mock(AppGenerator)
      project_name = "vraptor-scaffold"
      option = "--package=br.com.caelum"
      @args = [project_name, option]
      AppGenerator.stub!(:new).with(project_name, [option]).and_return(@generator)
    end

    it "should invoke all app generator tasks when typed new" do
      @help.stub!(:help).and_return false
      @generator.should_receive(:invoke_all)
      @generator_runner.new.run(@args)
    end
  end

  context "gae app generator" do
    before(:each) do
      @generator = mock(GaeAppGenerator)
      project_name = "gae-project"
      option = "--gae"
      @args = [project_name, option]
      GaeAppGenerator.stub!(:new).with(project_name, [option]).and_return(@generator)
    end

    it "should invoke all app generator tasks when typed new" do
      @help.stub!(:help).and_return false
      @generator.should_receive(:invoke_all)
      @generator_runner.new.run(@args)
    end
  end
end
