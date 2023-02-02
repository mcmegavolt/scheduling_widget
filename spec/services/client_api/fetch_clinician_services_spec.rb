# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClientApi::FetchClinicianServices do
  let(:service_id) { '3866' }

  subject(:call_service_result) do
    VCR.use_cassette(
      :fetch_clinical_services,
      erb: { service_id: service_id, service_description: '' }
    ) do
      ClientApi::FetchClinicianServices.call
    end
  end

  it 'fetches a services' do
    expect(call_service_result.first).to match [a_hash_including(id: service_id)]
  end

  it 'has no errors' do
    expect(call_service_result.second).to match_array([])
  end

  context 'when an error occurs' do
    it 'returns an error message' do
      connection = class_double(Faraday)
      allow(Faraday).to receive(:new).and_return(connection)
      allow(connection).to receive(:get).and_raise(Faraday::Error, 'error message')

      expect(call_service_result.second).to match_array(['error message'])
    end
  end
end
