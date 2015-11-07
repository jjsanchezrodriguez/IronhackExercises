Rails.application.routes.draw do
  root "application#index"
  resources :concerts, only: [:index, :show, :new, :create]

  get "/search" => "concerts#search"
  post "/search/by_price" => "concerts#search_by_price"
  get "/search/by_price" => "concerts#search_by_price"

  get "/popular" => "concerts#popular"


end
