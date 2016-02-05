Rails.application.routes.draw do

  api :version => 1, module: "api/v1" do
    resources :eins, param: :ein
  end

  root to: "static_pages#index"

  post "lookup" => "static_pages#lookup"

end
