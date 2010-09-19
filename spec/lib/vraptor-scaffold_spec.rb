require File.expand_path(File.dirname(__FILE__) + "/../spec_helper")

describe VraptorScaffold::Main do

  context "app generator help" do
    before(:each) do
      generator = mock(AppGenerator)
      generator.stub!(:invoke_all)
      AppGenerator.stub!(:new).and_return(generator)
      AppGenerator.should_receive(:start).with(["-h"])
      Kernel.should_receive(:exit)
    end 

    it "should print help when vraptor" do
      VraptorScaffold::Main.execute([])
    end

    it "should print help when vraptor -h" do
      VraptorScaffold::Main.execute(["-h"])
    end

    it "should print help when vraptor --help" do
      VraptorScaffold::Main.execute(["--help"])
    end

    it "should print help when vraptor new" do
      VraptorScaffold::Main.execute(["new"])
    end

    it "should print help when vraptor new -h" do
      VraptorScaffold::Main.execute(["new", "-h"])
    end

    it "should print help when vraptor new --help" do
      VraptorScaffold::Main.execute(["new", "--help"])
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
      VraptorScaffold::Main.execute(@args)
    end
  end

  context "scaffold generator help" do
    before(:each) do
      File.stub!(:exist?).and_return(true)
      generator = mock(ScaffoldGenerator)
      generator.stub!(:invoke_all)
      ScaffoldGenerator.stub!(:new).and_return(generator)
      ScaffoldGenerator.should_receive(:start).with(["-h"])
      Kernel.should_receive(:exit)
    end 

    it "should print help when vraptor scaffold" do
      VraptorScaffold::Main.execute(["scaffold"])
    end

    it "should print help when vraptor scaffold -h" do
      VraptorScaffold::Main.execute(["scaffold", "-h"])
    end

    it "should print help when vraptor scaffold --help" do
      VraptorScaffold::Main.execute(["scaffold", "--help"])
    end
  end

  context "scaffold generator" do
    before(:each) do
      @generator = mock(ScaffoldGenerator)
      @args = ["scaffold", "product", "name:string", "value:doulbe"]
      ScaffoldGenerator.stub!(:new).with(@args).and_return(@generator)
    end

    it "should invoke all scaffold generator tasks" do
      File.stub!(:exist?).and_return(true)
      @generator.should_receive(:invoke_all)
      VraptorScaffold::Main.execute(@args)
    end

    it "cannot invoke scaffold generator outsite root folder" do
      File.stub!(:exist?).and_return(false)
      Kernel.should_receive(:exit)
      @generator.stub!(:invoke_all)
      VraptorScaffold::Main.execute(@args)
    end
  end
end
