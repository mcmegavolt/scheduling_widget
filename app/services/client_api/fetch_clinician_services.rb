# frozen_string_literal: true

module ClientApi
  # Fetches a clinician avaliable services
  class FetchClinicianServices < Base
    GET_PATH = '/client-portal-api/cpt-codes'

    attr_reader :services

    def initialize
      super

      @services = []
    end

    def call
      fetch_data

      [services, errors]
    end

    private

    def fetch_data
      response = connection(request_params).get(GET_PATH)

      @services = response.body.with_indifferent_access[:data]
    rescue Faraday::Error => e
      add_error(e.message)
    end

    def request_params
      { filter: { clinicianId: clinician_id } }
    end
  end
end
