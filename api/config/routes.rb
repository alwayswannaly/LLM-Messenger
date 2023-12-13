Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api do
    resources :prompt, only: %i[index] do
      get '/stream', action: 'stream'
    end
  end
end
