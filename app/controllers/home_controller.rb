# frozen_string_literal: true

class HomeController < ActionController::Base
  def index
    @services = ClientApi::FetchClinicianServices.call
  end
end
