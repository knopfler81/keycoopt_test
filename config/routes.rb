Rails.application.routes.draw do
  root to: 'pages#home'
  resources :publications , only: [:create, :index, :show]
  resources :bills

  resources :publications do
    resources :bills, only: [:new, :create]
  end
end
