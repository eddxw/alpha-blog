Rails.application.routes.draw do
  root 'pages#homepage'
  get 'about', to: 'pages#about' 

  resources :articles

  get 'signup', to: 'users#new'
  resources :users, except: [:new]

  mount Peek::Railtie => '/peek'
  root to: 'home#show'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
