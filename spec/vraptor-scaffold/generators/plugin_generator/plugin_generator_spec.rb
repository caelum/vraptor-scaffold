require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe PluginGenerator do

  before :all do
    @project_path = "test_for_plugins"
    FileUtils.rm_rf(@project_path)
    @maven_projet = "#{@project_path}/maven"
    @gradle_projet = "#{@project_path}/gradle"
    @ant_projet = "#{@project_path}/ant"

    AppGenerator.new(@maven_projet, ["-b=mvn"]).invoke_all
    AppGenerator.new(@gradle_projet, ["-b=gradle"]).invoke_all
    AppGenerator.new(@ant_projet, ["-b=ant"]).invoke_all
  end
  
  def expected_for(name)
    File.join File.dirname(__FILE__), "expected_configs", name
  end
  
  context "maven project" do

    before :each do
      FileUtils.chdir(@maven_projet)
      @generator = PluginGenerator.new(["vraptor-environment", "0.0.8"])
      @generator.build
      back
    end

    it "should inject dependency into pom.xml" do
      source = expected_for "default_org_pom.xml"
      destination = "#{@maven_projet}/pom.xml"
      exists_and_identical?(source, destination)
    end
  end

  context "maven project with plugin org" do

    before :each do
      FileUtils.chdir(@maven_projet)
      @generator = PluginGenerator.new(["vraptor-environment", "0.0.8", "br.com.caelum.vraptor.plugin"])
      @generator.build
      back
    end

    it "should inject dependency into pom.xml" do
      source = expected_for "pom.xml"
      destination = "#{@maven_projet}/pom.xml"
      exists_and_identical?(source, destination)
    end
  end

  context "ant project" do

    before :each do
      FileUtils.chdir(@ant_projet)
      @generator = PluginGenerator.new(["vraptor-environment", "0.0.8"])
      @generator.build
      back
    end

    it "should inject dependency into ivy.xml" do
      source = expected_for "default_org_ivy.xml"
      destination = "#{@ant_projet}/ivy.xml"
      exists_and_identical?(source, destination)
    end
  end

  context "ant project with plugin org" do

    before :each do
      FileUtils.chdir(@ant_projet)
      @generator = PluginGenerator.new(["vraptor-environment", "0.0.8", "br.com.caelum.vraptor.plugin"])
      @generator.build
      back
    end

    it "should inject dependency into ivy.xml" do
      source = expected_for "ivy.xml"
      destination = "#{@ant_projet}/ivy.xml"
      exists_and_identical?(source, destination)
    end
  end

  context "gradle project" do

    before :each do
      FileUtils.chdir(@gradle_projet)
      @generator = PluginGenerator.new(["vraptor-environment", "0.0.8"])
      @generator.build
      back
    end

    it "should inject dependency into build.gradle" do
      source = expected_for "default_org_build.gradle"
      destination = "#{@gradle_projet}/build.gradle"
      exists_and_identical?(source, destination)
    end
  end

  context "gradle project with plugin org" do

    before :each do
      FileUtils.chdir(@gradle_projet)
      @generator = PluginGenerator.new(["vraptor-environment", "0.0.8", "br.com.caelum.vraptor.plugin"])
      @generator.build
      back
    end

    it "should inject dependency into build.gradle" do
      source = expected_for "build.gradle"
      destination = "#{@gradle_projet}/build.gradle"
      exists_and_identical?(source, destination)
    end
  end

  def back
    FileUtils.chdir("..")
    FileUtils.chdir("..")
  end

end
