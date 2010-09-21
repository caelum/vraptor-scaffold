require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe AppGenerator do

  context "build new application" do
    before(:all) do
      @project_path = "src/vraptor-scaffold"
      AppGenerator.new(@project_path, ["-b=mvn"]).invoke_all
    end

    after(:all) do
      FileUtils.remove_dir("src")
    end

    it "should create directory with project name" do
      File.exist?(@project_path).should be_true 
    end

    it "should create pom" do
      source =  File.join File.dirname(__FILE__), "templates", "pom.xml"
      destination = "#{@project_path}/pom.xml"
      exists_and_identical?(source, destination)
    end

    it "cannot create ivy.xml" do
      File.exist?("#{@project_path}/ivy.xml").should be_false  
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
        File.exist?("#{@app}/controllers").should be_true 
      end

      it "should create models folder" do
        File.exist?("#{@app}/models").should be_true 
      end

      it "should create generic entity" do
        source = File.join File.dirname(__FILE__), "templates", "Entity.java"
        destination = "#{@app}/models/Entity.java"
        exists_and_identical?(source, destination)
      end

      it "should create generic repository" do
        source =  File.join File.dirname(__FILE__), "templates", "Repository.java"
        destination = "#{@app}/repositories/Repository.java"
        exists_and_identical?(source, destination)
      end
    end

    context "creating main resources" do
      before(:all) do
        @main_resources = "#{@project_path}/#{Configuration::MAIN_RESOURCES}"
        @meta_inf = "#{@main_resources}/META-INF"
      end 

      it "should create resource folder" do
        File.exist?(@main_resources).should be_true 
      end

      it "should create log4j" do
        source = "#{AppGenerator.source_root}/resources/log4j.properties"
        destination = "#{@main_resources}/log4j.properties"
        exists_and_identical?(source, destination)
      end

      it "should create messages resource" do
        source = "#{AppGenerator.source_root}/resources/messages.properties"
        destination = "#{@main_resources}/messages.properties"
        exists_and_identical?(source, destination)
      end

      it "should create META-INF" do
        File.exist?(@meta_inf).should be_true 
      end

      it "should create persistence.xml" do
        source = "#{AppGenerator.source_root}/resources/META-INF/persistence.xml"
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

      it "should create jquery js" do
        source = "#{AppGenerator.source_root}/webapp/javascripts/jquery-1.4.2.min.js"
        destination = "#{@webapp}/javascripts/jquery-1.4.2.min.js"
        exists_and_identical?(source, destination)
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
        File.exist?("#{@app}/controllers").should be_true 
      end

      it "should create models folder" do
        File.exist?("#{@app}/models").should be_true 
      end

      it "should create respositories folder" do
        File.exist?("#{@app}/repositories").should be_true 
      end    

      it "should create test resource folder" do
        File.exist?(@test_resource).should be_true 
      end
    end    
  end

  context "build app with complex package" do

    before(:all) do
      @project_path = "src/vraptor-scaffold"
      AppGenerator.new(@project_path, ["-p=br.com.caelum"]).invoke_all
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
      FreemarkerTemplateEngine.stub!(:new).with(@project_path).and_return(template)
      template.should_receive(:configure)
      AppGenerator.new(@project_path, ["--template-engine=ftl"]).invoke_all
    end

    it "should configure jsp template engine" do
      template = mock(JspTemplateEngine)
      JspTemplateEngine.stub!(:new).with(@project_path).and_return(template)
      template.should_receive(:configure)
      AppGenerator.new(@project_path).invoke_all
    end
  end

  context "configuring ant application" do

    before(:all) do
      @project_path = "vraptor-scaffold"
      AppGenerator.new(@project_path, ["-b=ant"]).invoke_all
    end

    after(:all) do
      FileUtils.remove_dir(@project_path)
    end

    it "should create build.xml" do
      File.exist?("#{@project_path}/build.xml").should be_true  
    end

    it "should create ivy.xml" do
      File.exist?("#{@project_path}/ivy.xml").should be_true  
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
  end

  it "should configure banner" do
    AppGenerator.banner.should == "vraptor new PROJECT_PATH [options]"
  end

end
