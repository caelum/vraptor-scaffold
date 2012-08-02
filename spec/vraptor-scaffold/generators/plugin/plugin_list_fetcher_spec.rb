require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe PluginListFetcher do

	context "should download list of plugins available" do
		PluginListFetcher.fetch
	end
end
