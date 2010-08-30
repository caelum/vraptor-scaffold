require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe AppGenerator do

  before(:all) do
    @project_path = "src/vraptor-scaffold"
    AppGenerator.new(@project_path).invoke_all
  end

  after(:all) do
    FileUtils.remove_dir("src")
  end

  context "build new application" do
    it "should create directory with project name" do
      File.exist?(@project_path).should be_true 
    end

    it "should create pom" do
      from = File.expand_path(File.dirname(__FILE__) + "/templates/pom.xml")
      to = "#{@project_path}/pom.xml"
      FileUtils.compare_file(from, to).should be_true
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
        from = "#{AppGenerator.source_root}/Entity.java"
        to = "#{@app}/models/Entity.java"
        FileUtils.compare_file(from, to).should be_true
      end

      it "should create infrastructure folder" do
        File.exist?("#{@app}/infrastructure").should be_true 
      end

      it "should create path resolver" do
        from = "#{AppGenerator.source_root}/FreemarkerPathResolver.java"
        to = "#{@app}/infrastructure/FreemarkerPathResolver.java"
        FileUtils.compare_file(from, to).should be_true
      end

      it "should create generic repository" do
        from = "#{AppGenerator.source_root}/Repository.java"
        to = "#{@app}/repositories/Repository.java"
        FileUtils.compare_file(from, to).should be_true
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
        from = "#{AppGenerator.source_root}/resources/log4j.properties"
        to = "#{@main_resources}/log4j.properties"
        FileUtils.compare_file(from, to).should be_true
      end

      it "should create messages resource" do
        from = "#{AppGenerator.source_root}/resources/messages.properties"
        to = "#{@main_resources}/messages.properties"
        FileUtils.compare_file(from, to).should be_true
      end

      it "should create META-INF" do
        File.exist?(@meta_inf).should be_true 
      end

      it "should create persistence.xml" do
        from = "#{AppGenerator.source_root}/resources/META-INF/persistence.xml"
        to = "#{@meta_inf}/persistence.xml"
        FileUtils.compare_file(from, to).should be_true
      end
    end

    context "creating webapp" do
      before(:all) do
        @webapp = "#{@project_path}/#{Configuration::WEB_APP}"
        @web_inf = "#{@project_path}/#{Configuration::WEB_INF}"
        @decorators = "#{@webapp}/decorators"
      end 

      it "should create webapp folder" do
        File.exist?(@webapp).should be_true 
      end

      it "should create index" do
        from = "#{AppGenerator.source_root}/webapp/index.jsp"
        to = "#{@webapp}/index.jsp"
        FileUtils.compare_file(from, to).should be_true
      end

      it "should create decorators folder" do
        File.exist?(@decorators).should be_true 
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

      it "should create WEB-INF folder" do
        File.exist?(@web_inf).should be_true 
      end

      it "should create decorators.xml" do
        from = "#{AppGenerator.source_root}/webapp/WEB-INF/decorators.xml"
        to = "#{@web_inf}/decorators.xml"
        FileUtils.compare_file(from, to).should be_true
      end

      it "should create web.xml" do
        from = "#{AppGenerator.source_root}/webapp/WEB-INF/web.xml"
        to = "#{@web_inf}/web.xml"
        FileUtils.compare_file(from, to).should be_true
      end

      it "should create views folder" do
        File.exist?("#{@web_inf}/views").should be_true 
      end

      it "should create scaffold css" do
        from = "#{AppGenerator.source_root}/webapp/stylesheets/scaffold.css"
        to = "#{@webapp}/stylesheets/scaffold.css"
        FileUtils.compare_file(from, to).should be_true
      end

      it "should create jquery js" do
        from = "#{AppGenerator.source_root}/webapp/javascripts/jquery-1.4.2.min.js"
        to = "#{@webapp}/javascripts/jquery-1.4.2.min.js"
        FileUtils.compare_file(from, to).should be_true
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

      it "should create test resource folder" do
        File.exist?(@test_resource).should be_true 
      end
    end    
  end
end
