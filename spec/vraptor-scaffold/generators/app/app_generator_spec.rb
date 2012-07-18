require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe AppGenerator do

  context "build new application" do
    before(:all) do
      @project_path = "src/vraptor-scaffold"
      AppGenerator.new(@project_path, ["-b=mvn", "-r=repository", "-m=domain", "-c=control", "--skip_jquery"]).invoke_all
    end

    after(:all) do
      FileUtils.remove_dir("src")
    end

    it "should create directory with project name" do
      File.exist?(@project_path).should be_true
    end

    it "should be invalid when project name already exist" do
      Kernel.should_receive(:exit)
      AppGenerator.new(@project_path, ["--skip_jquery"])
    end

    it "should create pom" do
      source =  File.join File.dirname(__FILE__), "templates", "pom.xml"
      destination = "#{@project_path}/pom.xml"
      exists_and_identical?(source, destination)
    end

    it "cannot create ivy.xml" do
      File.exist?("#{@project_path}/ivy.xml").should be_false
    end

    it "cannot create build.gradle" do
      File.exist?("#{@project_path}/build.gradle").should be_false
    end

    it "cannot create eclipse wtp" do
      File.exist?("#{@project_path}/.classpath").should be_false
    end

    it "should configure vraptor-scaffold.properties" do
      source = File.join File.dirname(__FILE__), "templates", "vraptor-scaffold.properties"
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

      it "should create generic entity" do
        source = File.join File.dirname(__FILE__), "templates", "Entity.java"
        destination = "#{@app}/domain/Entity.java"
        exists_and_identical?(source, destination)
      end

      it "should create generic repository" do
        source =  File.join File.dirname(__FILE__), "templates", "RepositoryJPA.java"
        destination = "#{@app}/repository/Repository.java"
        exists_and_identical?(source, destination)
      end
    end

    context "creating main resources" do
      before(:each) do
        @main_resources = "#{@project_path}/#{Configuration::MAIN_RESOURCES}"
        @meta_inf = "#{@main_resources}/META-INF"
      end

      context "hibernate orm" do
        before(:all) do
          @project_path = "src/vraptor-scaffold-hibernate"
          @main_resources = "#{@project_path}/#{Configuration::MAIN_RESOURCES}"
          @meta_inf = "#{@main_resources}/META-INF"
          AppGenerator.new(@project_path, ["--orm=hibernate", "--skip_jquery"]).invoke_all
        end

        after(:all) do
          FileUtils.remove_dir("src/vraptor-scaffold-hibernate")
        end

        it "should create hibernate.cfg.xml" do
          source = "#{AppGenerator.source_root}/orm/hibernate.cfg.xml"
          destination = "#{@main_resources}/hibernate.cfg.xml"
          exists_and_identical?(source, destination)
        end

        it "cannot create META-INF" do
          File.exist?(@meta_inf).should be_false
        end

        it "cannot create persistence.xml" do
          File.exist?("#{@meta_inf}/persistence.xml").should be_false
        end
      end

      it "should create resource folder" do
        File.exist?(@main_resources).should be_true
      end

      it "should create log4j" do
        source = "#{AppGenerator.source_root}/resources/log4j.properties"
        destination = "#{@main_resources}/log4j.properties"
        exists_and_identical?(source, destination)
      end

      it "should create messages.properties" do
        source = "#{AppGenerator.source_root}/resources/messages.properties"
        destination = "#{@main_resources}/messages.properties"
        exists_and_identical?(source, destination)
      end

      it "should create hibernate.properties" do
        source = "#{AppGenerator.source_root}/resources/hibernate.properties"
        destination = "#{@main_resources}/hibernate.properties"
        exists_and_identical?(source, destination)
      end

      it "cannot create hibernate.cfg.xml" do
        File.exist?("#{@main_resources}/hibernate.cfg.xml").should be_false
      end

      it "should create META-INF" do
        File.exist?(@meta_inf).should be_true
      end

      it "should create persistence.xml" do
        source = "#{AppGenerator.source_root}/orm/persistence.xml"
        destination = "#{@meta_inf}/persistence.xml"
        exists_and_identical?(source, destination)
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
        source = "#{AppGenerator.source_root}/webapp/index.jsp"
        destination = "#{@webapp}/index.jsp"
        exists_and_identical?(source, destination)
      end

      it "should create WEB-INF folder" do
        File.exist?(@web_inf).should be_true
      end

      it "should create scaffold css" do
        source = "#{AppGenerator.source_root}/webapp/stylesheets/scaffold.css"
        destination = "#{@webapp}/stylesheets/scaffold.css"
        exists_and_identical?(source, destination)
      end

      it "should create stylesheets css" do
        source = "#{AppGenerator.source_root}/webapp/stylesheets/application.css"
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
      AppGenerator.new(@project_path, ["-p=br.com.caelum", "--skip_jquery"]).invoke_all
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

    it "should configure freemarker template engine" do
      template = mock(FreemarkerTemplateEngine)
      FreemarkerTemplateEngine.stub!(:new).with(@project_path, anything()).and_return(template)
      template.should_receive(:configure)
      AppGenerator.new(@project_path, ["--template-engine=ftl", "--skip_jquery"]).invoke_all
    end

    it "should configure jsp template engine" do
      template = mock(JspTemplateEngine)
      JspTemplateEngine.stub!(:new).with(@project_path, anything()).and_return(template)
      template.should_receive(:configure)
      AppGenerator.new(@project_path, ["--skip_jquery"]).invoke_all
    end
  end

  context "configuring ant application" do

    before(:all) do
      @project_path = "vraptor-scaffold"
      AppGenerator.new(@project_path, ["-b=ant", "--skip_jquery"]).invoke_all
    end

    after(:all) do
      FileUtils.remove_dir(@project_path)
    end

    it "should create build.xml" do
      source = File.join File.dirname(__FILE__), "templates", "build.xml"
      destination = "#{@project_path}/build.xml"
      exists_and_identical?(source, destination)
    end

    it "should create build.properties" do
      source =  File.join File.dirname(__FILE__), "templates", "build.properties"
      destination = "#{@project_path}/build.properties"
      exists_and_identical?(source, destination)
    end

    it "should create ivy.xml" do
      source =  File.join File.dirname(__FILE__), "templates", "ivy.xml"
      destination = "#{@project_path}/ivy.xml"
      exists_and_identical?(source, destination)
    end

    it "should copy ivy.jar" do
      ivy = File.join @project_path, AppGenerator::IVY_JAR
      File.exist?(ivy).should be_true
    end

    it "cannot create pom.xml" do
      File.exist?("#{@project_path}/pom.xml").should be_false
    end

    it "cannot create build.gradle" do
      File.exist?("#{@project_path}/build.gradle").should be_false
    end

    context "eclipse wtp configuration" do
      it "should create .project" do
        project = File.join @project_path, ".project"
        File.exist?(project).should be_true
      end

      it "should create .classpath" do
        class_path = File.join @project_path, ".classpath"
        File.exist?(class_path).should be_true
      end

      it "should create .settings" do
        settings = File.join @project_path, ".settings"
        File.exist?(settings).should be_true
      end
    end
  end

  context "skip eclipse configuration files" do
    before(:all) do
      @project_path = "vraptor-scaffold"
      AppGenerator.new(@project_path, ["--skip-eclipse", "--skip_jquery"]).invoke_all
    end

    after(:all) do
      FileUtils.remove_dir(@project_path)
    end

    it "cannot create .classpath file" do
      File.exist?("#{@project_path}/.classpath").should be_false
    end
  end

  context "no skip jquery download file" do
    before(:all) do
      @project_path = "vraptor-scaffold"

      mock_http_request()

      AppGenerator.new(@project_path).invoke_all
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
      AppGenerator.new(local_project_path).invoke_all

      FileUtils.remove_dir(local_project_path)
    end
  end

  context "configuring gradle application" do

    before(:all) do
      @project_path = "vraptor-scaffold"
      AppGenerator.new(@project_path, ["-b=gradle", "--skip_jquery"]).invoke_all
    end

    after(:all) do
      FileUtils.remove_dir(@project_path)
    end

    it "should create build.gradle" do
      source = File.join File.dirname(__FILE__), "templates", "build.gradle"
      destination = "#{@project_path}/build.gradle"
      exists_and_identical?(source, destination)
    end

    it "cannot create ivy.xml" do
      File.exist?("#{@project_path}/ivy.xml").should be_false
    end

    it "cannot create pom.xml" do
      File.exist?("#{@project_path}/pom.xml").should be_false
    end
  end

  context "valid template engines" do
    it "jsp should be valid" do
      AppGenerator::TEMPLATE_ENGINES.include?("jsp").should be_true
    end

    it "freemarker should be valid" do
      AppGenerator::TEMPLATE_ENGINES.include?("ftl").should be_true
    end
  end

  context "valid build tools" do
    it "ant should be valid" do
      AppGenerator::BUILD_TOOLS.include?("ant").should be_true
    end

    it "maven should be valid" do
      AppGenerator::BUILD_TOOLS.include?("mvn").should be_true
    end

    it "gradle should be valid" do
      AppGenerator::BUILD_TOOLS.include?("gradle").should be_true
    end
  end

  context "valid orm" do
    it "jpa should be valid" do
      AppGenerator::ORMS.include?("jpa").should be_true
    end

    it "hibernate should be valid" do
      AppGenerator::ORMS.include?("hibernate").should be_true
    end
  end

  it "should configure banner" do
    AppGenerator.banner.should == "vraptor new PROJECT_PATH [options]"
  end

  context "validate options" do
    before(:each) do
      @project_path = "vraptor-scaffold"
    end

    it "should be invalid when build tool is not supported" do
      Kernel.should_receive(:exit)
      AppGenerator.new(@project_path, ["-b=maven", "--skip_jquery"])
    end

    it "should be invalid when template engine is not supported" do
      Kernel.should_receive(:exit)
      AppGenerator.new(@project_path, ["-e=velocity", "--skip_jquery"])
    end

    it "should be invalid when orm mapping is not supported" do
      Kernel.should_receive(:exit)
      AppGenerator.new(@project_path, ["-o=toplink", "--skip_jquery"])
    end

    it "should be invalid when gae and heroku are selected" do
      Kernel.should_receive(:exit)
      AppGenerator.new(@project_path, ["-g", "-h", "--skip_jquery"])
    end
  end

  context "heroku app" do
    before(:all) do
      @project_path = "heroku"
      AppGenerator.new(@project_path, ["--heroku", "--skip_jquery"]).invoke_all
    end

    after(:all) do
      FileUtils.remove_dir(@project_path)
    end

    it "should create pom" do
      source = File.join File.dirname(__FILE__), "templates", "pom-heroku.xml"
      destination = "#{@project_path}/pom.xml"
      exists_and_identical?(source, destination)
    end

    it "should create Procfile" do
      File.exist?("#{@project_path}/Procfile").should be_true
    end

    it "should create main class to run heroku apps" do
      File.exist?("#{@project_path}/src/main/java/Main.java").should be_true
    end
  end

  context "gae app" do
    before(:all) do
      @project_path = "gae"
      AppGenerator.new(@project_path, ["--gae", "--skip_jquery"]).invoke_all
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

end
