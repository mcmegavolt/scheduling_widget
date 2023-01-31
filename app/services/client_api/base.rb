# frozen_string_literal: true

module ClientApi
  # Base class for ClientApi services
  class Base
    API_VERSION = '2019-01-17'
    ACCEPT = 'application/vnd.api+json'
    APPLICATION_BUILD_VERSION = '0.0.0'
    APPLICATION_PLATFORM = 'web'

    attr_reader :base_url, :clinician_id, :errors

    def initialize
      @base_url = Rails.application.config.client_api.client_portal_base_url
      @clinician_id = Rails.application.config.client_api.clinician_id
      @errors = []
    end

    def self.call(*args, &block)
      new(*args, &block).call
    end

    def connection(request_params)
      @connection ||= Faraday.new(
        url: base_url,
        params: request_params,
        headers: request_headers
      ) do |f|
        f.response :json
      end
    end

    def request_headers
      {
        'api-version': API_VERSION,
        'accept': ACCEPT,
        'application-build-version': APPLICATION_BUILD_VERSION,
        'application-platform': APPLICATION_PLATFORM
      }
    end

    def add_error(message)
      errors << message
    end

    def failed?
      errors.any?
    end
  end
end
