require 'spec_helper'

describe PluginGenerator do

  before :all do
    @project_path = "test_for_plugins"

    @maven_projet = "#{@project_path}/maven"
    @gradle_projet = "#{@project_path}/gradle"
    @ant_projet = "#{@project_path}/ant"

    AppGenerator.new(@maven_projet, ["-b=mvn"]).invoke_all
    AppGenerator.new(@gradle_projet, ["-b=gradle"]).invoke_all
    AppGenerator.new(@ant_projet, ["-b=ant"]).invoke_all
  end

  after :all do
    FileUtils.rm_rf(@project_path)
  end

  def expected_for(name)
    File.join File.dirname(__FILE__), "expected_configs", name
  end

  it "should configure banner" do
    PluginGenerator.banner.should == "vraptor plugin NAME [options]"
  end

  context "maven project" do

    before :each do
      backup @maven_projet, 'pom.xml'
    end

    it "should inject dependency into pom.xmlwith default" do
      PluginGenerator.new("vraptor-environment", ["-v=0.0.8"]).build
      back
      source = expected_for "default_org_pom.xml"
      destination = "#{@maven_projet}/pom.xml"
      exists_and_identical?(source, destination)
    end

    it "injects dependency into pom.xml with provided org" do
      PluginGenerator.new("vraptor-environment", ["-v=0.0.8", "-g=br.com.caelum.vraptor.plugin"]).build
      back
      source = expected_for "pom.xml"
      destination = "#{@maven_projet}/pom.xml"
      exists_and_identical?(source, destination)
    end

    after :each do
      rollback @maven_projet, 'pom.xml'
    end
  end

  context "ant project" do

    before :each do
      backup @ant_projet, 'ivy.xml'
    end

    it "should inject dependency into ivy.xml with default org" do
      PluginGenerator.new("vraptor-environment", ["-v=0.0.8"]).build
      back
      source = expected_for "default_org_ivy.xml"
      destination = "#{@ant_projet}/ivy.xml"
      exists_and_identical?(source, destination)
    end

    it "injects dependency into ivy.xml with provided org" do
      PluginGenerator.new("vraptor-environment", ["-v=0.0.8", "-g=br.com.caelum.vraptor.plugin"]).build
      back
      source = expected_for "ivy.xml"
      destination = "#{@ant_projet}/ivy.xml"
      exists_and_identical?(source, destination)
    end

    after :each do
      rollback @ant_projet, 'ivy.xml'
    end
  end

  context "gradle project" do

    before :each do
      backup @gradle_projet, 'build.gradle'
    end

    it "injects dependency into build.gradle with default org" do
      PluginGenerator.new("vraptor-environment", ["-v=0.0.8"]).build
      back
      source = expected_for "default_org_build.gradle"
      destination = "#{@gradle_projet}/build.gradle"
      exists_and_identical?(source, destination)
    end

    it "should inject dependency into build.gradle" do
      PluginGenerator.new("vraptor-environment", ["-v=0.0.8", "-g=br.com.caelum.vraptor.plugin"]).build
      back
      source = expected_for "build.gradle"
      destination = "#{@gradle_projet}/build.gradle"
      exists_and_identical?(source, destination)
    end

    after :each do
      rollback @gradle_projet, 'build.gradle'
    end
  end

  def back
    FileUtils.chdir("..")
    FileUtils.chdir("..")
  end

  def backup dir_path, file_name
    FileUtils.cp("#{dir_path}/#{file_name}", "#{dir_path}/#{file_name}.original")
    FileUtils.chdir(dir_path)
  end

  def rollback dir_path, file_name
    FileUtils.cp("#{dir_path}/#{file_name}.original", "#{dir_path}/#{file_name}")
  end
end
