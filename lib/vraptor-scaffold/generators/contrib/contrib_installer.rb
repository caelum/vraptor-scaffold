require 'rest-client'
require 'json'

class ContribInstaller < VraptorScaffold::Base

  argument :contrib_name

  def self.banner
    "vraptor contrib install contrib_name"
  end

  def initialize(args, opts=[])
    super([args], opts)
    validate
  end

  def find_lib
    vraptor_maven_libs = find_maven_jar

    if found(vraptor_maven_libs)
      say_status(:status, "found contrib on official maven repo.")
      add_dependency_to_build_tool vraptor_maven_libs
    else
      say_status(:status, "not found contrib on official maven repo.")
      ContribList.new(nil).download unless File.exists?(".vraptor-contrib")
      clone_repo_from_github
      install_lib_on_local_repo
    end
  end

  private
  def validate
    unless File.exist?("src")
      Kernel.puts "To run 'vraptor contrib install' please go to the project root folder."
      Kernel::exit
    end
  end

  def add_dependency_to_build_tool vraptor_maven_libs
    contrib_selected = vraptor_maven_libs['response']['docs'][0]

    contrib_name = contrib_selected['a']
    contrib_version = contrib_selected['latestVersion']
    contrib_package = contrib_selected['g']

    PluginGenerator.new(contrib_name, ["-v=" << contrib_version, "-g=" << contrib_package]).build
  end

  def clone_repo_from_github
    YAML.load_file(".vraptor-contrib").each do |contrib|
      if contrib_name.eql?(contrib[0])
        Kernel.system("git clone -q #{contrib[1]}.git")
        break
      end
    end
  end

  def install_lib_on_local_repo
    FileUtils.chdir("#{contrib_name}")

    if is_maven?
      say_status(:status, "maven build tool")
      say_status(:install, "installing contrib on local repo... will try run tests too.")
      Kernel.system("mvn --quiet install")
    elsif is_ivy?
      Kernel.puts("ivy install")
    elsif is_gradle?
      Kernel.puts("gradle install")
    else
      Kernel.puts("There is no build tool. Cancelling the 'contrib install'")
    end

    FileUtils.chdir("..")
  end

  def find_maven_jar
    @contrib_name = contrib_name
    #from terminal contrib_name is an array []. I don't know why. :(
    @contrib_name = contrib_name.shift if contrib_name.respond_to?(:shift)
    params = {:params => {:q => @contrib_name, :wt => :json}}
    response = RestClient.get 'http://search.maven.org/solrsearch/select', params
    JSON.parse(response.to_str) if response.code == 200
  end

  def found(vraptor_maven_libs)
    vraptor_maven_libs and vraptor_maven_libs['response']['docs'].size >= 1
  end

  def is_ivy?
    File.exist?("ivy.xml")
  end

  def is_gradle?
    File.exist?("build.gradle")
  end

  def is_maven?
    File.exist?("pom.xml")
  end
end
