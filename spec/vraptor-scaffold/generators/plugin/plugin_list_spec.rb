require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe PluginList do

  context "plugin list" do

    before(:each) do
    end

    it "should download one plugin available" do
      Kernel.should_receive(:system)
      File.should_receive(:readlines).and_return(["path = vraptor-plugin", "url = http://plugin.url"])

      vraptor_plugins = mock(File)
      vraptor_plugins.should_receive(:puts).with("vraptor-plugin: http://plugin.url\n")
      vraptor_plugins.should_receive(:close)

      File.should_receive(:open).twice.and_return(vraptor_plugins)
      YAML.should_receive(:load_file).with(".vraptor-contrib").and_return({"vraptor-plugin" => "http://plugin.url\n"})
      Kernel.should_receive(:puts).with("vraptor-plugin").ordered
      Kernel.should_receive(:puts).with("\nend.").ordered

      PluginList.show
    end

    it "should download list of plugins available" do
      Kernel.should_receive(:system)

      plugins_available = ["path = vraptor-plugin",
                           "url = http://plugin.url",
                           "path = vraptor-plugin-two",
                           "url = http://plugin-two.url"]

      File.should_receive(:readlines).and_return(plugins_available)

      vraptor_plugins = mock(File)
      vraptor_plugins.should_receive(:puts).with("vraptor-plugin: http://plugin.url\nvraptor-plugin-two: http://plugin-two.url\n").ordered
      vraptor_plugins.should_receive(:close)


      File.should_receive(:open).twice.and_return(vraptor_plugins)
      YAML.should_receive(:load_file).with(".vraptor-contrib").and_return({})
      Kernel.should_receive(:puts).with("\nend.")

      PluginList.show
    end

  end
end
