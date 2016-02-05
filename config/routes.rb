Rails.application.routes.draw do

  # api_version(:module => "v1", :header => {:name => "Accept", :value => "application/json; version=1"}, :defaults => {:format => "json"}) do
  #   resources :eins, only: [:show], param: :ein
  # end

  api_version(:module => "v1" :defaults => {:format => "json"}, :default => true) do
    resources :eins, only: [:show], param: :ein
  end


  # The rest of the app
  root to: "static_pages#index"
  post "lookup" => "static_pages#lookup"

end
