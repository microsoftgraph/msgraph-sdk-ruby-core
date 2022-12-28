require 'microsoft_kiota_faraday'
require_relative 'middleware/telemetry_handler'
module MicrosoftGraphCore
	class GraphClientFactory
		def self.get_default_middleware(options)
			middleware = MicrosoftKiotaFaraday::KiotaClientFactory.get_default_middleware
			middleware << MicrosoftGraphCore::Middleware::TelemetryHandler.new(options)
			return middleware
		end
		def self.get_default_http_client(options, middleware=nil)
			if middleware.nil? then #empty is fine in case the user doesn't want to use any middleware
				middleware = get_default_middleware(options)
			end
			client = MicrosoftKiotaFaraday::KiotaClientFactory.get_default_http_client(middleware)
			return client
		end
	end
end