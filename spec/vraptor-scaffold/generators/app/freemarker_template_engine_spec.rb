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
      AppGenerator.new(@project_path, ["--template-engine=ftl", "-p=br.com.caelum", "--orm=hibernate", "--skip-jquery"]).invoke_all
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
      source = File.join File.dirname(__FILE__), "templates", "freemarker-web.xml"
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
      source = File.join File.dirname(__FILE__), "templates", "FreemarkerPathResolver.java"
      destination = "#{@app}/infrastructure/FreemarkerPathResolver.java"
      exists_and_identical?(source, destination)
    end

    it "should create decorator file" do
      destination = "#{@decorators}/main.ftl"
      File.exist?(destination)
    end

    it "should create html macro file" do
      source = "#{FreemarkerTemplateEngine.source_root}/macros/html.ftl"
      destination = "#{@webapp}/macros/html.ftl"
      exists_and_identical?(source, destination)
    end
  end

  context "building a freemarker application" do
    context "with jquery" do
      before(:all) do
        @project_path = "src/vraptor-scaffold-with-jquery"
        @web_inf = "#{@project_path}/#{Configuration::WEB_INF}"
        @decorators = "#{@web_inf}/views/decorators"

        mock_http_request()

        AppGenerator.new(@project_path, ["--template-engine=ftl"]).invoke_all
      end

      after(:all) do
        FileUtils.remove_dir("src/vraptor-scaffold-with-jquery")
      end

      it "should create a main file with jquery js import" do
        source = File.join File.dirname(__FILE__), "templates", "main-with-jquery.ftl"
        destination = "#{@decorators}/main.ftl"
        exists_and_identical?(source, destination)
      end
    end

    context "building a freemarker application without jquery" do
      before(:all) do
        @project_path = "src/vraptor-scaffold-without-jquery"
        @web_inf = "#{@project_path}/#{Configuration::WEB_INF}"
        @decorators = "#{@web_inf}/views/decorators"
        AppGenerator.new(@project_path, ["--template-engine=ftl", "--skip-jquery"]).invoke_all
      end

      after(:all) do
        FileUtils.remove_dir("src/vraptor-scaffold-without-jquery")
      end

      it "should create a main file with jquery js import" do
        source = File.join File.dirname(__FILE__), "templates", "main-without-jquery.ftl"
        destination = "#{@decorators}/main.ftl"
        exists_and_identical?(source, destination)
      end
    end
  end
end
