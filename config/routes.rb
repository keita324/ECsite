Rails.application.routes.draw do

  scope module: :public do
    root :to =>"homes#top"
    get "/about"=>"homes#about"
    get '/customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe_customer'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    get 'customers/my_page' => 'customers#show', as: 'my_page'
    get '/orders/thanks' => 'orders#thanks', as: 'order_thanks'
    resources :customers, only: [:edit, :update]
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete 'cart_items' => 'cart_items#destroy_all', as: 'destroy_all'
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :orders, only: [:new, :create, :index, :show]
    post '/orders/confirm' => 'orders#confirm', as: 'order_confirm'
   
    
  end


  namespace :admin do
    root :to =>"homes#top"
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end

  # 顧客用
  # /customers/sign_in ...
  devise_for :customers,skip: [:passwords,], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }





end
