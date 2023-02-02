# frozen_string_literal: true

class LocationsController < ApplicationController
  def index
    @locations, @errors = ClientApi::FetchServiceLocations.call(params[:service_id])
  end
end
