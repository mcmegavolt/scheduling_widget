# frozen_string_literal: true

class LocationsController < ActionController::Base
  def show
    # base_url = 'https://johnny-appleseed.clientsecure.me'
    base_url = Rails.application.config.client_api.client_portal_base_url
    clinician_id = Rails.application.config.client_api.clinician_id

    conn = Faraday.new(
      url: base_url,
      params: { filter: { clinicianId: clinician_id, cptCodeId: params[:id] } },
      headers: {
        'api-version': '2019-01-17',
        'accept': 'application/vnd.api+json',
        'application-build-version': '0.0.0',
        'application-platform': 'web'
      }
    ) do |f|
      f.response :json
    end

    response = conn.get('/client-portal-api/offices')

    @locations = response.body.with_indifferent_access[:data]
  end
end
