require 'rest-client'
require 'json'
require 'xmlsimple'

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
      say_status(:status, "downloading contrib plugin from github...")
      ContribList.new(nil).download unless File.exists?(".vraptor-contrib")
      clone_repo_from_github
      install_lib_on_local_repo
      delete_contrib_clone_repo
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
        remote_url = contrib[1]
        remote_url << ".git" unless /\.git$/.match(contrib[1])

        Kernel.system("git clone -q #{remote_url} #{contrib_name}")
        break
      end
    end
  end

  def install_lib_on_local_repo
    say_status(:status, "installing contrib on local repo... will try run tests too.")

    if is_maven?
      Kernel.system("mvn install --quiet -f #{contrib_name}/pom.xml")
      pom = XmlSimple.xml_in("#{contrib_name}/pom.xml")

      PluginGenerator.new(pom["artifactId"].first, ["-v=" << pom["version"].first, "-g=" << pom["groupId"].first]).build
    elsif is_ivy?
      error_n_close "The contrib plugin has using ivy. Isn't supported yet."
    elsif is_gradle?
      error_n_close "The contrib plugin has using gradle. Isn't supported yet."
    else
      error_n_close "The contrib plugin has no build tool. Exiting installation."
    end
  end

  def delete_contrib_clone_repo
    FileUtils.rm_rf("#{contrib_name}")
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

  def error_n_close message
    say_status(:error, message, :red)
    FileUtils.rm_rf("#{contrib_name}")
    Kernel::exit
  end

  def is_ivy?
    File.exist?("#{contrib_name}/ivy.xml")
  end

  def is_gradle?
    File.exist?("#{contrib_name}/build.gradle")
  end

  def is_maven?
    File.exist?("#{contrib_name}/pom.xml")
  end
end
