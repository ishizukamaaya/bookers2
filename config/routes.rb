Rails.application.routes.draw do

  devise_for :users
  resources :books
  resources :users, only:[:show,:edit,:index,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  root to:'homes#top'
  get 'home/about' => 'homes#about'

 
end
