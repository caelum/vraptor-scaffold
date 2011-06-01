require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe PluginGenerator do
  
  context "ivy" do
    before(:each) do
      FileUtils.cp("./default_configs/ivy.xml", "./ivy.xml")
      @generator = PluginGenerator.new(["vraptor-environment", "0.0.8", "br.com.caelum.vraptor.plugin"])
      @generator.build
    end

    after(:each) do
      FileUtils.rm("./ivy.xml")
    end

    it "should inject dependency into ivy.xml" do
      source = File.join File.dirname(__FILE__), "expected_configs", "ivy.xml"
      destination = File.join File.dirname(__FILE__), "ivy.xml"
      exists_and_identical?(source, destination)
    end
  end

  context "ivy with default plugin_org" do
    before(:each) do
      FileUtils.cp("./default_configs/ivy.xml", "./ivy.xml")
      @generator = PluginGenerator.new(["vraptor-environment", "0.0.8"])
      @generator.build
    end

    after(:each) do
      FileUtils.rm("./ivy.xml")
    end

    it "should inject dependency into ivy.xml" do
      source = File.join File.dirname(__FILE__), "expected_configs", "default_org_ivy.xml"
      destination = File.join File.dirname(__FILE__), "ivy.xml"
      exists_and_identical?(source, destination)
    end
  end

  context "maven" do
    before(:each) do
      FileUtils.cp("./default_configs/pom.xml", "./pom.xml")
      @generator = PluginGenerator.new(["vraptor-environment", "0.0.8", "br.com.caelum.vraptor.plugin"])
      @generator.build
    end

    after(:each) do
      FileUtils.rm("./pom.xml")
    end

    it "should inject dependency into pom.xml" do
      source = File.join File.dirname(__FILE__), "expected_configs", "pom.xml"
      destination = File.join File.dirname(__FILE__), "pom.xml"
      exists_and_identical?(source, destination)
    end
  end
  
  context "maven with default plugin_org" do
    before(:each) do
      FileUtils.cp("./default_configs/pom.xml", "./pom.xml")
      @generator = PluginGenerator.new(["vraptor-environment", "0.0.8"])
      @generator.build
    end

    after(:each) do
      FileUtils.rm("./pom.xml")
    end

    it "should inject dependency into pom.xml" do
      source = File.join File.dirname(__FILE__), "expected_configs", "default_org_pom.xml"
      destination = File.join File.dirname(__FILE__), "pom.xml"
      exists_and_identical?(source, destination)
    end
  end

  context "gradle" do
    before(:each) do
      FileUtils.cp("./default_configs/build.gradle", "./build.gradle")
      @generator = PluginGenerator.new(["vraptor-environment", "0.0.8", "br.com.caelum.vraptor.plugin"])
      @generator.build
    end

    after(:each) do
      FileUtils.rm("./build.gradle")
    end

    it "should inject dependency into build.gradle" do
      source = File.join File.dirname(__FILE__), "expected_configs", "build.gradle"
      destination = File.join File.dirname(__FILE__), "build.gradle"
      exists_and_identical?(source, destination)
    end
  end

  context "gradle with default plugin_org" do
    before(:each) do
      FileUtils.cp("./default_configs/build.gradle", "./build.gradle")
      @generator = PluginGenerator.new(["vraptor-environment", "0.0.8"])
      @generator.build
    end

    after(:each) do
      FileUtils.rm("./build.gradle")
    end

    it "should inject dependency into pom.xml" do
      source = File.join File.dirname(__FILE__), "expected_configs", "default_org_build.gradle"
      destination = File.join File.dirname(__FILE__), "build.gradle"
      exists_and_identical?(source, destination)
    end
  end

end
