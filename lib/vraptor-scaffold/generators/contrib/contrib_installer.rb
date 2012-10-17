require 'rest-client'
require 'json'

class ContribInstaller < VraptorScaffold::Base

  argument :contrib_name

  def self.banner
    "vraptor contrib install contrib_name"
  end

  def initialize(args, opts=[])
    super(args, opts)
    validate
  end

  def find_lib
    response = RestClient.get 'http://search.maven.org/solrsearch/select', {:params => {:q => contrib_name, 'wt' => 'json'}}
    vraptor_maven_libs = JSON.parse(response.to_str) if response.code == 200

    if found(vraptor_maven_libs)
      contrib_selected = vraptor_maven_libs['response']['docs'][0]

      contrib_name = contrib_selected['a']
      contrib_version = contrib_selected['latestVersion']
      contrib_package = contrib_selected['g']

      @generator = PluginGenerator.new(contrib_name, ["-v=" << contrib_version, "-g=" << contrib_package]).build
    end
  end

  def is_ivy?
    File.exist?("ivy.xml")
  end

  def is_maven?
    File.exist?("pom.xml")
  end

  private
  def validate
    unless File.exist?("src")
      Kernel.puts "To run 'vraptor contrib install' please go to the project root folder."
      Kernel::exit
    end
  end

  def found(vraptor_maven_libs)
    vraptor_maven_libs and vraptor_maven_libs['response']['docs'].size >= 1
  end

end
