require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe ContribList do

  context "contrib list" do

    before(:each) do
    end

    it "should have a banner" do
      ContribList.banner == "vraptor contrib list"
    end

    it "should download one contrib available" do
      Kernel.should_receive(:system)
      File.should_receive(:readlines).and_return(["path = vraptor-contrib", "url = http://contrib.url"])

      vraptor_contrib = mock(File)
      vraptor_contrib.should_receive(:puts).with("vraptor-contrib: http://contrib.url\n")
      vraptor_contrib.should_receive(:close)

      File.should_receive(:open).twice.and_return(vraptor_contrib)
      YAML.should_receive(:load_file).with(".vraptor-contrib").and_return({"vraptor-contrib" => "http://contrib.url\n"})
      Kernel.should_receive(:puts).with("vraptor-contrib").ordered
      Kernel.should_receive(:puts).with("\nend.").ordered

      ContribList.new("list").invoke_all
    end

    it "should download list of contribs available" do
      Kernel.should_receive(:system)

      contribs_available = ["path = vraptor-contrib",
                           "url = http://contrib.url",
                           "path = vraptor-contrib-two",
                           "url = http://contrib-two.url"]

      File.should_receive(:readlines).and_return(contribs_available)

      vraptor_contrib = mock(File)
      vraptor_contrib.should_receive(:puts).with("vraptor-contrib: http://contrib.url\nvraptor-contrib-two: http://contrib-two.url\n").ordered
      vraptor_contrib.should_receive(:close)


      File.should_receive(:open).twice.and_return(vraptor_contrib)
      YAML.should_receive(:load_file).with(".vraptor-contrib").and_return({})
      Kernel.should_receive(:puts).with("\nend.")

      ContribList.new("list").invoke_all
    end

  end
end
