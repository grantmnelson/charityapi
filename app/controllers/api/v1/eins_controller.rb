class Api::V1::EinsController < Api::V1::BaseController
  version 1
  def show
    expose Organization.find_by_ein(params[:ein].to_s)
  end
end
