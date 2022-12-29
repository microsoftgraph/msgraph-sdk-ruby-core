# frozen_string_literal: true
require 'faraday'
require 'rbconfig'
require 'securerandom'
require_relative '../graph_client_options'
require_relative '../version_information'

module MicrosoftGraphCore
	module Middleware
		class TelemetryHandler < Faraday::Middleware
			@@default_option = GraphClientOptions.new
			def call(request_env)
				request_option = request_env[:request][:context][@@default_option.get_key] unless request_env[:request].nil? || request_env[:request][:context].nil?
                request_option = @@default_option if request_option.nil?
				header_value = get_header_value(request_option)
                unless header_value.nil? || header_value.empty? || request_env[:request_headers].nil? then
                    request_env[:request_headers]["SdkVersion"] = header_value
                    request_env[:request_headers]["client-request-id"] = SecureRandom.uuid
                end
                @app.call(request_env) unless app.nil?
            end

			def get_header_value(options)
				if options.nil? then
					options = GraphClientOptions.new
				end
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
				return service_version_prefix + "graph-ruby-core/" + MicrosoftGraphCore::VersionInformation::VERSION + feature_suffix
			end
		end
	end
end