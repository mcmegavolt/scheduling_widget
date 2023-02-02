# frozen_string_literal: true

class ServicesController < ApplicationController
  def index
    @services, @errors = ClientApi::FetchClinicianServices.call
  end
end
