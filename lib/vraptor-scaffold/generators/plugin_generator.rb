class PluginGenerator < VraptorScaffold::Base

  argument :plugin_name

  def self.banner
    "vraptor plugin install #{self.arguments.map(&:usage).join(' ')}"
  end

  def initialize(opts)
    super(opts)
  end

end