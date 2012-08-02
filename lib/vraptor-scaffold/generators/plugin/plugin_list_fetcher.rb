require "net/https"
require "uri"

class PluginListFetcher

	VRAPTOR_PLUGINS_URI = "/caelum/vraptor-contrib/master/.gitmodules"

	def self.fetch
		puts fetch_plugins_text_list
	end

	private
	def self.fetch_plugins_text_list
		uri = URI.parse("https://raw.github.com/caelum/vraptor-contrib/master/.gitmodules")
		http = Net::HTTP.new(uri.host, uri.port)

		http.use_ssl = true
		http.verify_mode = OpenSSL::SSL::VERIFY_NONE

		request = Net::HTTP::Get.new(uri.request_uri)

		response = http.request(request)
		response.body
	end
end
