# frozen_string_literal: true

class LocationsController < ActionController::Base
  def show
    @locations = ClientApi::FetchServiceLocations.call(params[:id])
  end
end
