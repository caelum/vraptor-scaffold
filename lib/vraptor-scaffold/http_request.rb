require 'net/http'

module VraptorScaffold

  class HttpRequest

    def self.open_session url
      return http.start url
    end

    protected

    def self.http
      return Net::HTTP unless ENV['http_proxy']
      uri = URI.parse(ENV['http_proxy'])
      proxy_user, proxy_pass = uri.userinfo.split(/:/) if uri.userinfo
      Net::HTTP::Proxy(uri.host, uri.port, proxy_user, proxy_pass)
    end

  end

end
