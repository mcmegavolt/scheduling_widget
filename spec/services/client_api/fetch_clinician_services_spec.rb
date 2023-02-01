# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClientApi::FetchClinicianServices do
  subject(:call_service_result) do
    VCR.use_cassette(:fetch_clinical_services) { ClientApi::FetchClinicianServices.call }
  end

  it 'fetches a services' do
    expect(call_service_result).to match [
      a_hash_including(id: '3866'),
      a_hash_including(id: '31822614')
    ]
  end
end
