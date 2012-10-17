require 'rest-client'

class ContribInstaller < VraptorScaffold::Base

  argument :contrib_name

  def self.banner
    "vraptor contrib install contrib_name"
  end

  def initialize(args, opts=[])
    super([args], opts)
    validate
    puts contrib_name
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

end
