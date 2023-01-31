# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe 'GET /index' do
    before do
      allow(ClientApi::FetchClinicianServices).to receive(:call).and_return([])

      get :index
    end

    it { expect(ClientApi::FetchClinicianServices).to have_received(:call) }
    it { expect(response).to be_successful }
  end
end
