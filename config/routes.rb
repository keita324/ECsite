Rails.application.routes.draw do

  scope module: :public do
    root :to =>"homes#top"
    get "/about"=>"homes#about"
    get '/customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe_customer'
    patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
    get 'customers/my_page' => 'customers#show', as: 'my_page'
    resources :customers, only: [:edit, :update]
    resources :items, only: [:index, :show]
  end


  namespace :admin do
    root :to =>"homes#top"
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
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
