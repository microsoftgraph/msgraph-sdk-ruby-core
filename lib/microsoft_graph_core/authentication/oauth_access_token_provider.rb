require 'microsoft_kiota_authentication_oauth'
module MicrosoftGraphCore
    module Authentication
        # Wrapper around the kiota access token provider with the Microsoft Graph defaults set up.
        class OAuthAccessTokenProvider < MicrosoftKiotaAuthenticationOAuth::OAuthAccessTokenProvider

            # This is the initializer for OAuthAccessTokenProvider.
            # :params
            #   token_request_context: a instance of one of our token request context or a custom implementation
            #   allowed_hosts: an array of strings, where each string is an allowed host, default is an array of Microsoft Graph hosts
            #   scopes: an array of strings, where each string is a scope, default is empty array 
            def initialize(token_request_context, allowed_hosts = [], scopes = [])
				if allowed_hosts.nil? || allowed_hosts.empty?
					allowed_hosts = ['graph.microsoft.com', 'graph.microsoft.us', 'dod-graph.microsoft.us',
						'graph.microsoft.de', 'microsoftgraph.chinacloudapi.cn',
						'canary.graph.microsoft.com']
				end
				super(token_request_context, allowed_hosts, scopes)
            end
        end
    end
end