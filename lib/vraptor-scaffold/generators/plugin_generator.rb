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
        plugin = "\t<dependency org=\"#{plugin_org}\" name=\"#{plugin_name}\" rev=\"#{plugin_version}\" conf=\"default\" />\n\t"
        inject_into_file("ivy.xml", plugin, :before=>"</dependencies>")
    elsif is_maven?
        plugin = "\t<dependency>\n\t\t\t<groupId>#{plugin_org}</groupId>\n\t\t\t<artifactId>#{plugin_name}</artifactId>\n\t\t\t<version>#{plugin_version}</version>\n\t\t</dependency>\n\t"
        inject_into_file("pom.xml", plugin, :before=>"</dependencies>")
    else
        plugin = "\n    compile group: '#{plugin_org}', name: '#{plugin_name}', version: '#{plugin_version}'\n"
        inject_into_file("build.gradle", plugin, :after=>"dependencies {")
    end
  end

  def is_ivy?
    File.exist?("ivy.xml")
  end

  def is_maven?
    File.exist?("pom.xml")
  end

end
