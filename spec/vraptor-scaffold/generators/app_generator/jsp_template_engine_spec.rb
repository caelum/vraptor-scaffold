require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe JspTemplateEngine do

  context "building a jsp application" do
    before(:all) do
      @project_path = "src/vraptor-scaffold"
      @web_inf = "#{@project_path}/#{Configuration::WEB_INF}"
      @decorators = "#{@web_inf}/jsp/decorators"
      @app = "#{@project_path}/#{Configuration::MAIN_SRC}/app"
      AppGenerator.new(@project_path).invoke_all
    end

    after(:all) do
      FileUtils.remove_dir("src")
    end

    it "should create decorators.xml" do
      source = File.join File.dirname(__FILE__), "templates", "decorators-jsp.xml"
      destination = "#{@web_inf}/decorators.xml"
      exists_and_identical?(source, destination)
    end

    it "should create views folder" do
      File.exist?("#{@web_inf}/jsp").should be_true 
    end

    it "should create decorator file" do
      source = "#{JspTemplateEngine.source_root}/main.jsp"
      destination = "#{@decorators}/main.jsp"
      exists_and_identical?(source, destination)
    end

    it "should not create infrastructure folder" do
      File.exist?("#{@app}/infrastructure").should be_false 
    end

    it "should not create path resolver" do
      to = "#{@app}/infrastructure/FreemarkerPathResolver.java"
      File.exist?(to).should be_false
    end
    
    it "should create web.xml" do
      source = File.join File.dirname(__FILE__), "templates", "jsp-web.xml"
      destination = "#{@web_inf}/web.xml"
      exists_and_identical?(source, destination)
    end
    
    it "should create prelude.jspf" do
      source = "#{JspTemplateEngine.source_root}/prelude.jspf"
      destination = "#{@web_inf}/jsp/prelude.jspf"
      exists_and_identical?(source, destination)
    end
  end
end