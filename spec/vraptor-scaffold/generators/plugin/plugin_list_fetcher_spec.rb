require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe PluginListFetcher do

  context "plugin list" do

    it "should download list of plugins available" do
      Kernel.should_receive(:system)
      PluginListFetcher.fetch
    end
  end
end
