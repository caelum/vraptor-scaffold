require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe GaeAppGenerator do

  context "build new application" do
    before(:all) do
      @project_path = "src/vraptor-scaffold"
      GaeAppGenerator.new(@project_path, ["-r=repository", "-m=domain", "-c=control", "--skip-jquery"]).invoke_all
    end

    after(:all) do
      FileUtils.remove_dir("src")
    end

    it "should create directory with project name" do
      File.exist?(@project_path).should be_true
    end

    it "should be invalid when project name already exist" do
      Kernel.should_receive(:exit)
      GaeAppGenerator.new(@project_path, ["--skip-jquery"])
    end

    it "should configure vraptor-scaffold.properties" do
      source = File.join File.dirname(__FILE__), "templates", "vraptor-scaffold-gae.properties"
      destination = "#{@project_path}/#{Configuration::FILENAME}"
      exists_and_identical?(source, destination)
    end

    context "creating main java" do
      before(:all) do
        @main_java = "#{@project_path}/#{Configuration::MAIN_SRC}"
        @app = "#{@main_java}/app"
      end

      it "should create source folder" do
        File.exist?(@main_java).should be_true
      end

      it "should create app folder" do
        File.exist?(@app).should be_true
      end

      it "should create controllers folder" do
        File.exist?("#{@app}/control").should be_true
      end

      it "should create models folder" do
        File.exist?("#{@app}/domain").should be_true
      end
    end

    context "creating webapp" do
      before(:all) do
        @webapp = "#{@project_path}/#{Configuration::WEB_APP}"
        @web_inf = "#{@project_path}/#{Configuration::WEB_INF}"
      end

      it "should create webapp folder" do
        File.exist?(@webapp).should be_true
      end

      it "should create index" do
        source = "#{GaeAppGenerator.source_root}/webapp/index.jsp"
        destination = "#{@webapp}/index.jsp"
        exists_and_identical?(source, destination)
      end

      it "should create WEB-INF folder" do
        File.exist?(@web_inf).should be_true
      end

      it "should create scaffold css" do
        source = "#{GaeAppGenerator.source_root}/webapp/stylesheets/scaffold.css"
        destination = "#{@webapp}/stylesheets/scaffold.css"
        exists_and_identical?(source, destination)
      end

      it "should create stylesheets css" do
        source = "#{GaeAppGenerator.source_root}/webapp/stylesheets/application.css"
        destination = "#{@webapp}/stylesheets/application.css"
        exists_and_identical?(source, destination)
      end

      it "should create application js" do
        destination = "#{@webapp}/javascripts/application.js"
        File.exists?(destination).should be_true
      end

      it "should create images folder" do
        File.exist?("#{@webapp}/images").should be_true
      end
    end

    context "creating test" do
      before(:all) do
        @test_java = "#{@project_path}/#{Configuration::TEST_SRC}"
        @test_resource = "#{@project_path}/#{Configuration::TEST_RESOURCES}"
        @app = "#{@test_java}/app"
      end

      it "should create test source folder" do
        File.exist?(@test_java).should be_true
      end

      it "should create app folder" do
        File.exist?(@app).should be_true
      end

      it "should create controllers folder" do
        File.exist?("#{@app}/control").should be_true
      end

      it "should create models folder" do
        File.exist?("#{@app}/domain").should be_true
      end

      it "should create respositories folder" do
        File.exist?("#{@app}/repository").should be_true
      end

      it "should create test resource folder" do
        File.exist?(@test_resource).should be_true
      end
    end
  end

  context "build app with complex package" do

    before(:all) do
      @project_path = "src/vraptor-scaffold"
      GaeAppGenerator.new(@project_path, ["-p=br.com.caelum", "--skip-jquery"]).invoke_all
      @main_java = "#{@project_path}/#{Configuration::MAIN_SRC}/br/com/caelum"
      @test_java = "#{@project_path}/#{Configuration::TEST_SRC}/br/com/caelum"
    end

    after(:all) do
      FileUtils.remove_dir("src")
    end

    it "should create main path" do
      File.exist?(@main_java).should be_true
    end

    it "should create test path" do
      File.exist?(@test_java).should be_true
    end

  end

  context "configuring template engine" do

    before(:each) do
      @project_path = "src/vraptor-scaffold"
    end

    after(:each) do
      FileUtils.remove_dir("src")
    end

    it "should configure jsp template engine" do
      template = mock(JspTemplateEngine)
      JspTemplateEngine.stub!(:new).with(@project_path, anything()).and_return(template)
      template.should_receive(:configure)
      GaeAppGenerator.new(@project_path, ["--skip-jquery"]).invoke_all
    end
  end

  context "skip eclipse configuration files" do
    before(:all) do
      @project_path = "vraptor-scaffold"
      GaeAppGenerator.new(@project_path, ["--skip-eclipse", "--skip-jquery"]).invoke_all
    end

    after(:all) do
      FileUtils.remove_dir(@project_path)
    end

    it "cannot create .classpath file" do
      File.exist?("#{@project_path}/.classpath").should be_false
    end
  end

  context "gae app" do
    before(:all) do
      @project_path = "gae"
      GaeAppGenerator.new(@project_path, ["--skip-jquery"]).invoke_all
      @main_java = "#{@project_path}/#{Configuration::MAIN_SRC}"
      @app = "#{@main_java}/app"
    end

    after(:all) do
      FileUtils.remove_dir(@project_path)
    end

    it "should create ivy.xml" do
      source = File.join File.dirname(__FILE__), "templates", "ivy-gae.xml"
      destination = "#{@project_path}/ivy.xml"
      exists_and_identical?(source, destination)
    end

    it "should create ivysettings.xml" do
      File.exist?("#{@project_path}/ivysettings.xml").should be_true
    end

    it "should not create generic entity" do
      File.exist?("#{@app}/model/Entity.java").should be_false
    end

    it "should create appengine-web xml to run gae apps" do
      File.exist?("#{@project_path}/#{Configuration::WEB_INF}/appengine-web.xml").should be_true
    end

    it "should create logging properties for gae apps" do
      File.exist?("#{@project_path}/#{Configuration::WEB_INF}/logging.properties").should be_true
    end

    it "should create web.xml" do
      source = File.join File.dirname(__FILE__), "templates", "gae-jsp-web.xml"
      destination = "#{@project_path}/#{Configuration::WEB_INF}/web.xml"
      exists_and_identical?(source, destination)
    end

    it "should generate a objectify repository" do
      source = File.join File.dirname(__FILE__), "templates", "RepositoryObjectify.java"
      destination = "#{@project_path}/#{Configuration::MAIN_SRC}/app/repositories/Repository.java"
      exists_and_identical?(source, destination)
    end

    it "should generate a objectify resource factory" do
      source = File.join File.dirname(__FILE__), "templates", "ObjectifyFactory.java"
      destination = "#{@project_path}/#{Configuration::MAIN_SRC}/app/infra/ObjectifyFactory.java"
      exists_and_identical?(source, destination)
    end

    it "should create a specific .classpath for gae" do
      source = File.join File.dirname(__FILE__), "templates", "classpath-gae"
      destination = "#{@project_path}/.classpath"
      exists_and_identical?(source, destination)
    end

    it "should create a specific .project for gae" do
      source = File.join File.dirname(__FILE__), "templates", "project-gae"
      destination = "#{@project_path}/.project"
      exists_and_identical?(source, destination)
    end

    it "should create .settings" do
      settings = File.join @project_path, ".settings"
      File.exist?(settings).should be_true
    end
  end

  context "no skip jquery download file" do
    before(:all) do
      @project_path = "vraptor-scaffold"

      mock_http_request()

      GaeAppGenerator.new(@project_path).invoke_all
    end

    after(:all) do
      FileUtils.remove_dir(@project_path)
    end

    it "should exist jquery.min.js file" do
      javascripts = File.join @project_path, Configuration::WEB_APP, "javascripts", "jquery.min.js"
      File.exist?(javascripts).should be_true
    end

    it "should show a message for http problems" do
      http_request = mock(Net::HTTP)
      http_request.stub!(:get).with(kind_of(String)).and_throw(Net::HTTPError)
      VraptorScaffold::HttpRequest.stub!(:open_session).with(kind_of(String)).and_return(http_request)

      Kernel.should_receive(:puts).with("Was not possible to download jQuery.")

      local_project_path = "project_without_jquery_by_http_error"
      GaeAppGenerator.new(local_project_path).invoke_all

      FileUtils.remove_dir(local_project_path)
    end
  end

end
