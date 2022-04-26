Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  devise_for :users
  root "homes#top"
  get "home/about"=>"homes#about", as: "about"
  get "search" => "searches#search"
  get "chat/:id" => "chats#show", as: "chat"

  resources :groups, only: [:new,:index,:show,:create,:edit,:update]
  resources :chats, only: [:create]
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]do
   resources :book_comments, only: [:create,:destroy]
   resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update]do
    resource :relationships, only: [:create,:destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get "daily_posts" => "users#daily_posts"
  end
end