class PluginGenerator < VraptorScaffold::Base

  argument :plugin_name
  argument :plugin_version
  argument :plugin_org, :default=>"br.com.caelum.vraptor"

  def self.banner
    "vraptor plugin #{self.arguments.map(&:usage).join(' ')}"
  end

  def initialize(opts)
    super(opts)
  end

  def build
    if is_ivy?
        plugin = "<dependency org=\"#{plugin_org}\" name=\"#{plugin_name}\" rev=\"#{plugin_version}\" conf=\"default\" />\n"
        inject_into_file("ivy.xml", plugin, :before=>"</dependencies>")
    elsif is_maven?
        plugin = "<dependency><groupId>#{plugin_org}</groupId><artifactId>#{plugin_name}</artifactId><version>#{plugin_version}</version></dependency>\n"
        inject_into_file("pom.xml", plugin, :before=>"<!-- Test dependencies -->")
    else
        plugin = "compile group: '#{plugin_org}', name: '#{plugin_name}', version: '#{plugin_version}'\n"
        inject_into_file("build.gradle", plugin, :before=>"//Test dependencies")
    end
  end

  def is_ivy?
    File.exist?("ivy.xml")
  end

  def is_maven?
    File.exist?("pom.xml")
  end

end
