require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe JspTemplateEngine do

  context "building a jsp application" do
    before(:all) do
      @project_path = "src/vraptor-scaffold"
      AppGenerator.new(@project_path, ["--template-engine=jsp"]).invoke_all
      @webapp = "#{@project_path}/#{Configuration::WEB_APP}"
      @web_inf = "#{@project_path}/#{Configuration::WEB_INF}"
      @decorators = "#{@web_inf}/decorators"
      @app = "#{@project_path}/#{Configuration::MAIN_SRC}/app"
    end

    after(:all) do
      FileUtils.remove_dir("src")
    end

    it "should create decorators.xml" do
      from = File.expand_path(File.dirname(__FILE__) + "/templates/decorators-jsp.xml")
      to = "#{@web_inf}/decorators.xml"
      FileUtils.compare_file(from, to).should be_true
    end

    it "should create web.xml" do
      from = "#{AppGenerator.source_root}/jsp-web.xml"
      to = "#{@web_inf}/web.xml"
      FileUtils.compare_file(from, to).should be_true
    end

    it "should create views folder" do
      File.exist?("#{@web_inf}/jsp").should be_true 
    end

    it "should create decorator file" do
      from = "#{AppGenerator.source_root}/main.jsp"
      to = "#{@decorators}/main.jsp"
      FileUtils.compare_file(from, to).should be_true
    end

    it "should not create infrastructure folder" do
      File.exist?("#{@app}/infrastructure").should be_false 
    end

    it "should not create path resolver" do
      to = "#{@app}/infrastructure/FreemarkerPathResolver.java"
      File.exist?(to).should be_false
    end

    it "should include jstl dependency" do
      pom = "#{@project_path}/pom.xml"
      File.read(pom).should match("<dependency><groupId>javax.servlet</groupId><artifactId>jstl</artifactId><version>1.2</version></dependency>")
    end

  end
end
