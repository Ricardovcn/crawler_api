Rails.application.routes.draw do
  #resources :quotes
  #resources :tags

  resources :auth, only: [:create]
  get '/quotes/:tag', to: "tags#show"
  get '/quotes', to: "tags#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
