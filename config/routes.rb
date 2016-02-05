Rails.application.routes.draw do



  # The rest of the app
  root to: "static_pages#index"
  post "lookup" => "static_pages#lookup"

end
