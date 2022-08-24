Rails.application.routes.draw do
  root to: "tweets#index"
  devise_for :users, :controllers =>{registrations:'registrations'}
  
  resources :tweets, :except =>[:edit] do
    # resources :comments, :except =>[:edit] do
    #   member do
    #     post :recomment
    #     get :recomment
    #   end
    # end
    member do
      post :retweet
      get :retweet
      get :likeables
      #resources :reply, :except=>[:edit,:index,:create], controller: :tweets
      get "/reply",to:"tweets#show_reply"
      post "/reply",to:"tweets#create_reply"
    end
  end

  resources :notifications do
    collection do
      post :mark_as_read
    end
  end

  resources :profiles do
    resources :friendships,only: [:create,:destroy]
    member do
      get :friendlist
    end
  end

  post 'like/:id',to: "tweets#like",as: "like_tweet"
  get  'like/:id',to: "tweets#like_button",as: "like_button"

 # post '/tweets/:tweet_id/comments/:id',to: "comments#like_comment",as: "like_comment"

  # scope module: 'admin' do
  #   resources :articles, :comments
  # end
  # Ex:- scope :active, -> {where(:active => true)}
  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
 
  
end
