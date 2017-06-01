Rails.application.routes.draw do
  resources :users
  resources :account_activations, only: [:edit]

  #static page routes
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'

  # User routes
  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  patch '/users/:id/edit', to: 'users#update', as: 'update_user'

  #Session routes
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
