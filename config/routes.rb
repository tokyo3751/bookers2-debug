Rails.application.routes.draw do
  get 'group_users/create'
  get 'group_users/destroy'
  get 'relationships/followings'
  get 'relationships/followers'
  devise_for :users
  root "homes#top"
  get "home/about"=>"homes#about", as: "about"
  get "search" => "searches#search"
  get "chat/:id" => "chats#show", as: "chat"

  resources :groups do
    resource :group_users, only: [:create,:destroy]
    resources :event_notices, only: [:new, :create]
    get "event_notices" => "event_notices#sent"
  end
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
   get "search_book" => "books#search_book"
end