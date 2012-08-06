require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe PluginList do

  context "plugin list" do

    it "should download list of plugins available" do
      PluginList.fetch
    end

    it "should download list of plugins available" do
#      File.should_receive(:readlines).and_return([])
#      PluginList.show
    end
  end
end
