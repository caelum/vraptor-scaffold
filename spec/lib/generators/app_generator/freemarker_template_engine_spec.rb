require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe FreemarkerTemplateEngine do

  context "building a freemarker application" do
    before(:all) do
      mock_config_file
      @project_path = "src/vraptor-scaffold"
      @webapp = "#{@project_path}/#{Configuration::WEB_APP}"
      @web_inf = "#{@project_path}/#{Configuration::WEB_INF}"
      @decorators = "#{@web_inf}/decorators"
      @app = "#{@project_path}/#{Configuration::MAIN_SRC}/app"
      AppGenerator.new(@project_path, ["--template-engine=ftl"]).invoke_all
    end

    after(:all) do
      FileUtils.remove_dir("src")
    end

    it "should create decorators.xml" do
      source = File.join File.dirname(__FILE__), "templates", "decorators.xml"
      destination = "#{@web_inf}/decorators.xml"
      exists_and_identical?(source, destination)
    end

    it "should create web.xml" do
      source = "#{AppGenerator.source_root}/freemarker-web.xml"
      destination = "#{@web_inf}/web.xml"
      exists_and_identical?(source, destination)
    end

    it "should create views folder" do
      File.exist?("#{@web_inf}/views").should be_true 
    end

    it "should create infrastructure folder" do
      File.exist?("#{@app}/infrastructure").should be_true 
    end

    it "should create path resolver" do
      source = File.expand_path(File.dirname(__FILE__) + "/templates/FreemarkerPathResolver.java")
      destination = "#{@app}/infrastructure/FreemarkerPathResolver.java"
      exists_and_identical?(source, destination)
    end

    it "should create decorator file" do
      source = "#{AppGenerator.source_root}/main.ftl"
      destination = "#{@decorators}/main.ftl"
      exists_and_identical?(source, destination)
    end

    it "should create html macro file" do
      source = "#{AppGenerator.source_root}/macros/html.ftl"
      destination = "#{@webapp}/macros/html.ftl"
      exists_and_identical?(source, destination)
    end

    it "should include freemarker dependency" do
      pom = "#{@project_path}/pom.xml"
      File.read(pom).should match("<dependency><groupId>org.freemarker</groupId><artifactId>freemarker</artifactId><version>2.3.16</version></dependency>")
    end
  end

end
