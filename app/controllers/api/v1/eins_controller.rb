module Api
  module V1

    class EinsController < ApplicationController
      respond_to :json
      def show
        respond_with Organization.find_by_ein(params[:ein].to_s)
      end
    end

    # Put other controller classes here ?

  end
end
