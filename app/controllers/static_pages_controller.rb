class StaticPagesController < ApplicationController
  def index
    # @eins = [
    #   "000003154",
    #   "000587764",
    #   "000635913",
    #   "000765634",
    #   "000841363",
    #   "000852649",
    #   "000889899",
    #   "001037180",
    #   "001085119",
    #   "002030711",
    #   "002067446",
    #   "002237333",
    #   "002293921",
    #   "002296179",
    #   "002296211",
    #   "007764840"
    # ]
    @eins = Organization.first(10).map { |o| o.ein}
  end

  def lookup
    ein = params[:ein].to_s
    @response = Organization.find_by_ein(ein)
    respond_to do |format|
      format.js
      format.json { render @response }
    end
  end
end
