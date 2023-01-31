# frozen_string_literal: true

module ClientApi
  # Fetches a clinician avaliable services
  class FetchClinicianServices < Base
    GET_PATH = '/client-portal-api/cpt-codes'

    def call
      response = connection(request_params).get(GET_PATH)

      response.body.with_indifferent_access[:data]
    end

    private

    def request_params
      { filter: { clinicianId: clinician_id } }
    end
  end
end
