module MicrosoftGraphCore
	class GraphClientOptions
		include MicrosoftKiotaAbstractions::RequestOption
		attr_accessor :graph_service_version, :graph_service_library_version
		def get_key()
			"telemetryOptions"
		end
	end
end