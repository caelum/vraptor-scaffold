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
      url = URI.parse("http://rubygems.org/gems/#{@who}")
      req = Net::HTTP::Get.new(url.path)
      res = Net::HTTP.start(url.host, url.port) {|http|
             http.request(req)
           }
        res.code == '200'
    end
    def install
        Gem::GemRunner.new.run ["install", @who]
    end
    def configure
        VraptorScaffold::Execution.new.run(["configure", @who])
    end
end