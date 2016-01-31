Rails.application.routes.draw do

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :eins, param: :ein
    end
  end

  root to: "static_pages#index"

  post "lookup" => "static_pages#lookup"
  
end
