require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe FreemarkerTemplateEngine do

  before(:all) do
    @project_path = "src/vraptor-scaffold"
    @webapp = "#{@project_path}/#{Configuration::WEB_APP}"
    @web_inf = "#{@project_path}/#{Configuration::WEB_INF}"
    @decorators = "#{@web_inf}/views/decorators"
    @app = "#{@project_path}/#{Configuration::MAIN_SRC}/br/com/caelum"
  end

  context "configuring" do
    before(:all) do
      AppGenerator.new(@project_path, ["--template-engine=ftl", "-p=br.com.caelum"]).invoke_all
    end

    after(:all) do
      FileUtils.remove_dir(@project_path)
    end

    it "should create decorators.xml" do
      source = File.join File.dirname(__FILE__), "templates", "decorators.xml"
      destination = "#{@web_inf}/decorators.xml"
      exists_and_identical?(source, destination)
    end

    it "should append freemarker servlet in web.xml" do
      source = File.join FreemarkerTemplateEngine.source_root, "freemarker-web.xml"
      web_xml = "#{@web_inf}/web.xml"
      File.read(web_xml).should include(File.read(source))
    end

    it "should create views folder" do
      File.exist?("#{@web_inf}/views").should be_true 
    end

    it "should create infrastructure folder" do
      File.exist?("#{@app}/infrastructure").should be_true 
    end

    it "should create path resolver" do
      source = File.join File.dirname(__FILE__), "templates", "FreemarkerPathResolver.java"
      destination = "#{@app}/infrastructure/FreemarkerPathResolver.java"
      exists_and_identical?(source, destination)
    end

    it "should create decorator file" do
      source = "#{FreemarkerTemplateEngine.source_root}/main.ftl"
      destination = "#{@decorators}/main.ftl"
      exists_and_identical?(source, destination)
    end

    it "should create html macro file" do
      source = "#{FreemarkerTemplateEngine.source_root}/macros/html.ftl"
      destination = "#{@webapp}/macros/html.ftl"
      exists_and_identical?(source, destination)
    end
  end
end