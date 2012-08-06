require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe PluginList do

  context "plugin list" do

    it "should download list of plugins available" do
      Kernel.should_receive(:system)
      File.should_receive(:readlines).and_return(["path = vraptor-plugin", "url = http://plugin.url"])

      vraptor_plugins = mock(File)
      vraptor_plugins.should_receive(:puts).with("vraptor-plugin = http://plugin.url")

      File.should_receive(:open).twice.and_return(vraptor_plugins)

      PluginList.show
    end

    it "should download list of plugins available" do
#      File.should_receive(:readlines).and_return([])
#      PluginList.show
    end
  end
end
