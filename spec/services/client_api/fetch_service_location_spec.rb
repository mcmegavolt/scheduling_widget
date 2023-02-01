# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ClientApi::FetchServiceLocations do
  subject(:call_service_result) do
    VCR.use_cassette(:fetch_service_locations) { ClientApi::FetchServiceLocations.call(3866) }
  end

  it 'fetches a service locations' do
    expect(call_service_result).to match [a_hash_including(id: '8377723')]
  end
end
