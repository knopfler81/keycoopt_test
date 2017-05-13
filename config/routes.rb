Rails.application.routes.draw do
  root to: 'pages#home'
  resources :publications, only: :create
end
