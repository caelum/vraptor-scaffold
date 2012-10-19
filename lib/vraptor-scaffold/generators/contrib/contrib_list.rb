require "net/https"
require "uri"

class ContribList < VraptorScaffold::Base

  VRAPTOR_PLUGINS_URI = "https://raw.github.com/caelum/vraptor-contrib/master/.gitmodules"

  def self.banner
    "vraptor contrib list"
  end

  def initialize(args, opts=[])
    super([args], opts)
  end

  def download
    Kernel.system("curl --progress-bar #{VRAPTOR_PLUGINS_URI} >> .vraptor-contrib-modules")

    create_new_contrib_file

    vraptor_contrib = File.open(".vraptor-contrib", "w")
    modules = File.readlines(".vraptor-contrib-modules")

    contrib_name_to_url = organize_file(modules)

    vraptor_contrib.puts(contrib_name_to_url)
    vraptor_contrib.close

    FileUtils.rm(".vraptor-contrib-modules") if File.exists?(".vraptor-contrib-modules")

    self
  end

  def show
    download unless File.exists?(".vraptor-contrib")

    YAML.load_file(".vraptor-contrib").each do |contrib|
      Kernel.puts contrib[0]
    end

    Kernel.puts "\nend."
  end

  def self.which_address_type_to_plugin contrib_name
    download unless File.exists?(".vraptor-contrib")

    @url_regex = /((https?|git)\:\/\/)[a-zA-Z0-9\-\.@]+\.[a-zA-Z]{2,3}(\/\S*)?/
    @ssh_regex = /[a-zA-Z0-9]+@[a-zA-Z0-9\/\.:-]+/

    File.readlines(".vraptor-contrib").each do |line|
      if /#{contrib_name}:/.match(line)
        return :url if @url_regex.match(line)
        return :ssh if @ssh_regex.match(line)
      end
    end

    :unkown
  end

  private
  def create_new_contrib_file
    FileUtils.rm(".vraptor-contrib") if File.exists?(".vraptor-contrib")
    FileUtils.touch(".vraptor-contrib")
  end

  def organize_file(git_modules_file)
    contrib_name_to_url = ""
    git_modules_file.each do |line|
      if line[/path =/]
        contrib_name = line[/= (.*)/][2..-1]
        contrib_name_to_url << contrib_name
      end
      if line[/url =/]
        contrib_address = line[/= (.*)/][2..-1]

        contrib_name_to_url << ": "
        contrib_name_to_url << contrib_address
        contrib_name_to_url << "\n"
      end
    end

    contrib_name_to_url
  end
end
