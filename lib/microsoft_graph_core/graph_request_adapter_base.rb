require 'microsoft_kiota_abstractions'
require "microsoft_kiota_faraday"
require_relative 'graph_client_factory'
require_relative 'graph_client_options'
module MicrosoftGraphCore
	class GraphRequestAdapterBase < MicrosoftKiotaFaraday::FaradayRequestAdapter
		def initialize(authentication_provider, client_options=MicrosoftGraphCore::GraphClientOptions.new, parse_node_factory=MicrosoftKiotaAbstractions::ParseNodeFactoryRegistry.default_instance, serialization_writer_factory=MicrosoftKiotaAbstractions::SerializationWriterFactoryRegistry.default_instance, client = nil)
			if client_options.nil?
				client_options = MicrosoftGraphCore::GraphClientOptions.new
			end
			if client.nil?
				client = MicrosoftGraphCore::GraphClientFactory::get_default_http_client(nil, [client_options])
			end
			super(authentication_provider, parse_node_factory, serialization_writer_factory, client)
		end
	end
end