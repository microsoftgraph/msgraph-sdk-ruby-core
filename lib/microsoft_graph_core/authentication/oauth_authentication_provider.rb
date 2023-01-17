require 'microsoft_kiota_abstractions'
require_relative 'oauth_access_token_provider'
module MicrosoftGraphCore
    module Authentication
        class OAuthAuthenticationProvider < MicrosoftKiotaAbstractions::BaseBearerTokenAuthenticationProvider
            def initialize(token_request_context, allowed_hosts, scopes)
                super(MicrosoftGraphCore::Authentication::OAuthAccessTokenProvider.new(token_request_context, allowed_hosts, scopes))
            end
        end
    end
end