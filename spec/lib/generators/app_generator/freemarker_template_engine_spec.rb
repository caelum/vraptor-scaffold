require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe FreemarkerTemplateEngine do

  context "building a freemarker application" do
    before(:all) do
      @project_path = "src/vraptor-scaffold"
      mock_config_file
      AppGenerator.new(@project_path, ["--template-engine=ftl"]).invoke_all
      @webapp = "#{@project_path}/#{Configuration::WEB_APP}"
      @web_inf = "#{@project_path}/#{Configuration::WEB_INF}"
      @decorators = "#{@web_inf}/decorators"
      @app = "#{@project_path}/#{Configuration::MAIN_SRC}/app"
    end

    after(:all) do
      FileUtils.remove_dir("src")
    end

    it "should create decorators.xml" do
      from = File.expand_path(File.dirname(__FILE__) + "/templates/decorators.xml")
      to = "#{@web_inf}/decorators.xml"
      FileUtils.compare_file(from, to).should be_true
    end

    it "should create web.xml" do
      from = "#{AppGenerator.source_root}/freemarker-web.xml"
      to = "#{@web_inf}/web.xml"
      FileUtils.compare_file(from, to).should be_true
    end

    it "should create views folder" do
      File.exist?("#{@web_inf}/views").should be_true 
    end

    it "should create infrastructure folder" do
      File.exist?("#{@app}/infrastructure").should be_true 
    end

    it "should create path resolver" do
      from = File.expand_path(File.dirname(__FILE__) + "/templates/FreemarkerPathResolver.java")
      to = "#{@app}/infrastructure/FreemarkerPathResolver.java"
      FileUtils.compare_file(from, to).should be_true
    end

    it "should create decorator file" do
      from = "#{AppGenerator.source_root}/main.ftl"
      to = "#{@decorators}/main.ftl"
      FileUtils.compare_file(from, to).should be_true
    end

    it "should create html macro file" do
      from = "#{AppGenerator.source_root}/macros/html.ftl"
      to = "#{@webapp}/macros/html.ftl"
      FileUtils.compare_file(from, to).should be_true
    end

    it "should include freemarker dependency" do
      pom = "#{@project_path}/pom.xml"
      File.read(pom).should match("<dependency><groupId>org.freemarker</groupId><artifactId>freemarker</artifactId><version>2.3.16</version></dependency>")
    end
  end

end
