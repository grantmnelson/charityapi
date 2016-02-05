class EinsController < V1::BaseController
  def show
    @organization = Organization.find_by_ein(params[:ein])
  end
end
