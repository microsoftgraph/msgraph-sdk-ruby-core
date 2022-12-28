# frozen_string_literal: true
require 'faraday'
require 'rbconfig'
require 'securerandom'
require_relative '../graph_client_options'
require_relative '../version_information'

module MicrosoftGraphCore
	module Middleware
		class TelemetryHandler < Faraday::Middleware
			def initialize(app = nil, options = MicrosoftGraphCore::GraphClientOptions.new)
				if options.nil? then
                    raise ArgumentError, 'options cannot be nil'
                end
                #assigning options isn't necessary as the parent constructor does it
                super(app, options)
				service_version_prefix = ""
				unless options.graph_service_library_version.nil? || options.graph_service_library_version.empty? then
					service_version_prefix = "graph-ruby"
					unless options.graph_service_version.nil? || options.graph_service_version.empty? then
						service_version_prefix += "-" + options.graph_service_version
					end
					service_version_prefix += "/" + options.graph_service_library_version + ","
				end
				feature_suffix = ""
				unless RbConfig::CONFIG["host_os"].nil? || RbConfig::CONFIG["host_os"].empty? then
					feature_suffix = " hostOS=" + RbConfig::CONFIG["host_os"] + ";"
				end
				unless RbConfig::CONFIG["host_cpu"].nil? || RbConfig::CONFIG["host_cpu"].empty? then
					feature_suffix += " hostArch=" + RbConfig::CONFIG["host_cpu"] + ";"
				end
				unless RbConfig::CONFIG["ruby_version"].nil? || RbConfig::CONFIG["ruby_version"].empty? then
					feature_suffix += " runtimeEnvironment=" + RbConfig::CONFIG["ruby_version"] + ";"
				end
				@header_value = service_version_prefix + "graph-ruby-core/" + MicrosoftGraphCore::VersionInformation::VERSION + feature_suffix
			end
			def call(request_env)
				
                unless @header_value.nil? || @header_value.empty? || request_env[:headers].nil? then
                    request_env[:headers]["SdkVersion"] = @header_value
                    request_env[:headers]["client-request-id"] = SecureRandom.uuid
                end
                @app.call(request_env) unless app.nil?
            end
		end
	end
end