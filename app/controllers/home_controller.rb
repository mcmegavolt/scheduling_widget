# frozen_string_literal: true

class HomeController < ActionController::Base
  def index
    base_url = Rails.application.config.client_api.client_portal_base_url
    clinician_id = Rails.application.config.client_api.clinician_id

    conn = Faraday.new(
      url: base_url,
      params: { filter: { clinicianId: clinician_id } },
      headers: {
        'api-version': '2019-01-17',
        'accept': 'application/vnd.api+json',
        'application-build-version': '0.0.0',
        'application-platform': 'web'
      }
    ) do |f|
      f.response :json
    end

    response = conn.get('/client-portal-api/cpt-codes')

    @services = response.body.with_indifferent_access[:data]
  end

  # TODO: Handle connection/response errors
end
