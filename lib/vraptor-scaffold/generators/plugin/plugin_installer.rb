class PluginInstaller < VraptorScaffold::Base

  argument :name

  def self.banner
    "vraptor plugin install plugin_name"
  end

  def initialize(args, opts=[])
    super([args], opts)
  end

  def is_ivy?
    File.exist?("ivy.xml")
  end

  def is_maven?
    File.exist?("pom.xml")
  end

end
