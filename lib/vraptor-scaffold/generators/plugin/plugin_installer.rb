class PluginInstaller < VraptorScaffold::Base

  argument :name

  def self.banner
    "vraptor plugin install plugin_name"
  end

  def initialize(args, opts=[])
    super([args], opts)
    validate
    puts name
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
      Kernel.puts "To run 'vraptor plugin install' please go to the project root folder."
      Kernel::exit
    end
  end

end
