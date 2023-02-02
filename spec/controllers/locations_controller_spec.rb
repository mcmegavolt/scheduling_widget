# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LocationsController, type: :controller do
  describe 'GET /index' do
    let(:service_id) { '-1' }

    before do
      allow(ClientApi::FetchServiceLocations).to receive(:call).with(service_id).and_return([])

      get :index, params: { service_id: service_id }
    end

    it { expect(ClientApi::FetchServiceLocations).to have_received(:call).with(service_id) }
    it { expect(response).to be_successful }
  end
end
