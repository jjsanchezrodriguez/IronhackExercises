Rails.application.routes.draw do
  root "application#index"
  resources :concerts, only: [:index, :show, :new, :create]
end
