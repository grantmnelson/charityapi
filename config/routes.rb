Rails.application.routes.draw do

  api_version(:module => "V1", :header => {:name => "Accept", :value => "application/vnd.mycompany.com; version=2"}, :defaults => {:format => "json"}, :default => true) do
    resources :eins, only: [:show], param: :ein
  end


  # The rest of the app
  root to: "static_pages#index"
  post "lookup" => "static_pages#lookup"

end
