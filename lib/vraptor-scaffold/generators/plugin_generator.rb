require 'rubygems'
require 'rubygems/gem_runner'
require 'net/http'

class VRaptorGem
    def initialize(who)
        @who = who
    end
    def install_and_configure
        if is_installed?
            configure
        elsif exists?
            install
            configure
        end
    end
    
    private
    def is_installed?
        Gem::GemPathSearcher.new.find(@who)
    end
    def exists?
        res = Net::HTTP.get(URI.parse("http://rubygems.org/gems/#{@who}"))
        res.code == '200'
    end
    def install
        Gem::GemRunner.new.run ["install", @who]
    end
    def configure
        VraptorScaffold::Execution.new.run(["configure", @who])
    end
end

class PluginGenerator < VraptorScaffold::Base

  argument :plugin_name
  argument :plugin_version
  argument :plugin_org, :default => "br.com.caelum.vraptor"

  def self.banner
    "vraptor plugin #{self.arguments.map(&:usage).join(' ')}"
  end

  def initialize(opts)
    super(opts)
  end

  def build
    if is_ivy?
      plugin = "\n\t\t<dependency org=\"#{plugin_org}\" name=\"#{plugin_name}\" rev=\"#{plugin_version}\" conf=\"default\" />"
      inject_into_file("ivy.xml", plugin, :after => "<dependencies>")
    elsif is_maven?
      plugin = "\n\t\t<dependency>\n\t\t\t<groupId>#{plugin_org}</groupId>\n\t\t\t<artifactId>#{plugin_name}</artifactId>\n\t\t\t<version>#{plugin_version}</version>\n\t\t</dependency>"
      inject_into_file("pom.xml", plugin, :after => "<dependencies>")
    else
      plugin = "\n    compile group: '#{plugin_org}', name: '#{plugin_name}', version: '#{plugin_version}'\n"
      inject_into_file("build.gradle", plugin, :after => "dependencies {")
    end
    VRaptorGem.new(plugin_name).install_and_configure
  end

  def is_ivy?
    File.exist?("ivy.xml")
  end

  def is_maven?
    File.exist?("pom.xml")
  end

end

