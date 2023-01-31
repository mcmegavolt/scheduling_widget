# frozen_string_literal: true

module ClientApi
  # Fetches a clinician avaliable services
  class FetchServiceLocations < Base
    REQUEST_PATH = '/client-portal-api/offices'

    attr_reader :service_id, :locations

    def initialize(service_id)
      super()

      @service_id = service_id
    end

    def call
      fetch_data

      return false if failed?

      locations
    end

    private

    def fetch_data
      response = connection(request_params).get(REQUEST_PATH)

      @locations = response.body.with_indifferent_access[:data]
    end

    def request_params
      {
        filter: {
          clinicianId: clinician_id,
          cptCodeId: service_id
        }
      }
    end
  end
end
