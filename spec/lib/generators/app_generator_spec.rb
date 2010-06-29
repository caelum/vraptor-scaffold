require File.expand_path(File.dirname(__FILE__) + "/../../spec_helper")

describe AppGenerator do
  
  before(:all) do
    @project_name = "vraptor-scaffold"
    AppGenerator.new.build(@project_name)
  end
  
  after(:all) do
    FileUtils.remove_dir(@project_name)
  end
   
  context "build new application" do
    it "should create directory with project name" do
      File.exist?(@project_name).should be_true 
    end
    
    it "should create pom" do
    	from = "#{AppGenerator.source_root}/templates/pom.xml"
        to = "#{@project_name}/pom.xml"
        FileUtils.compare_file(from, to).should be_true
    end
    
    context "creating main java" do
      before(:all) do
        @main_java = "#{@project_name}/src/main/java"
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
      
      it "should create infrastructure folder" do
        File.exist?("#{@app}/infrastructure").should be_true 
      end
      
      it "should create path resolver" do
        from = "#{AppGenerator.source_root}/templates/FreemarkerPathResolver.java"
        to = "#{@app}/infrastructure/FreemarkerPathResolver.java"
        FileUtils.compare_file(from, to).should be_true
      end
    end
    
    context "creating main resources" do
      before(:all) do
        @main_resources = "#{@project_name}/src/main/resources"
        @meta_inf = "#{@main_resources}/META-INF"
      end 
      
      it "should create resource folder" do
         File.exist?(@main_resources).should be_true 
      end
      
      it "should create log4j" do
        from = "#{AppGenerator.source_root}/templates/log4j.xml"
        to = "#{@main_resources}/log4j.xml"
        FileUtils.compare_file(from, to).should be_true
      end
      
      it "should create META-INF" do
         File.exist?(@meta_inf).should be_true 
      end
      
       it "should create log4j" do
        from = "#{AppGenerator.source_root}/templates/persistence.xml"
        to = "#{@meta_inf}/persistence.xml"
        FileUtils.compare_file(from, to).should be_true
      end
    end 
    context "creating webapp" do
      before(:all) do
        @webapp = "#{@project_name}/src/main/webapp"
        @web_inf = "#{@webapp}/WEB-INF"
      end 
      
      it "should create webapp folder" do
         File.exist?(@webapp).should be_true 
      end
      
      it "should create WEB-INF folder" do
         File.exist?(@web_inf).should be_true 
      end
    end   
  end
end
