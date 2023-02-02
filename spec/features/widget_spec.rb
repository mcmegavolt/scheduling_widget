# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Widget', type: :feature do
  let(:service_id) { '3866' }
  let(:service_description) { 'Psychiatric Diagnostic Evaluation' }
  let(:location_id) { '8377723' }
  let(:location_name) { 'Video Office' }

  before do
    VCR.insert_cassette(
      :fetch_clinical_services,
      erb: {
        service_id: service_id,
        service_description: service_description
      }
    )

    VCR.insert_cassette(
      :fetch_service_locations,
      erb: {
        service_id: service_id,
        location_id: location_id,
        location_name: location_name
      }
    )
  end

  after do
    VCR.eject_cassette :fetch_clinical_services
    VCR.eject_cassette :fetch_service_locations
  end

  scenario 'User visits a home page' do
    visit root_path

    expect(page).to have_text service_description
  end

  scenario 'User selects a service' do
    visit root_path
    click_link(href: service_locations_path(service_id))

    expect(page).to have_text location_name
  end

  context 'When no services are available' do
    scenario 'User visits a home page' do
      allow(ClientApi::FetchClinicianServices).to receive(:call).and_return([[], []])

      visit root_path

      expect(page).to have_text I18n.t('services.no_available')
    end
  end

  context 'When no service locations are available' do
    scenario 'User selects a service' do
      allow(ClientApi::FetchServiceLocations).to receive(:call).and_return([[], []])

      visit root_path
      click_link(href: service_locations_path(service_id))

      expect(page).to have_text I18n.t('locations.no_available')
    end
  end

  context 'When something went wrong' do
    let(:error_msg) { 'Timeout' }

    scenario 'User visits a home page' do
      allow(ClientApi::FetchClinicianServices).to receive(:call).and_return([[], [error_msg]])

      visit root_path

      expect(page).to have_text error_msg
    end

    scenario 'User selects a service' do
      allow(ClientApi::FetchServiceLocations).to receive(:call).and_return([[], [error_msg]])

      visit root_path
      click_link(href: service_locations_path(service_id))

      expect(page).to have_text error_msg
    end
  end
end
