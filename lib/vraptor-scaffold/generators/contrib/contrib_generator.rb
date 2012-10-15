class ContribGenerator < VraptorScaffold::Base

  argument :name

  class_option :group, :default => "br.com.caelum.vraptor", :aliases => "-g",
               :desc => "Contrib group"

  class_option :version, :aliases => "-v",
               :desc => "Contrib version"

  def self.banner
    "vraptor plugin #{self.arguments.map(&:usage).join(' ')} [options]"
  end

  def initialize(args, opts=[])
    super([args], opts)
    @version = options[:version]
    @group = options[:group]
  end

  def build
    if is_ivy?
      plugin = "\n\t\t<dependency org=\"#{@group}\" name=\"#{name}\" rev=\"#{@version}\" conf=\"default\" />"
      inject_into_file("ivy.xml", plugin, :after => "<dependencies>")
    elsif is_maven?
      plugin = "\n\t\t<dependency>\n\t\t\t<groupId>#{@group}</groupId>\n\t\t\t<artifactId>#{name}</artifactId>\n\t\t\t<version>#{@version}</version>\n\t\t</dependency>"
      inject_into_file("pom.xml", plugin, :after => "<dependencies>")
    else
      plugin = "\n    compile group: '#{@group}', name: '#{name}', version: '#{@version}'\n"
      inject_into_file("build.gradle", plugin, :after => "dependencies {")
    end
  end

  def is_ivy?
    File.exist?("ivy.xml")
  end

  def is_maven?
    File.exist?("pom.xml")
  end

end
