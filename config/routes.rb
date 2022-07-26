Rails.application.routes.draw do
  devise_for :users, :controllers =>{registrations:'registrations'}
  get 'home/index'

  resources :tweets, :except =>[:edit] do
    resources :comments
  end

  resources :profiles
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root to: "tweets#index"
  # Defines the root path route ("/")
  
end
