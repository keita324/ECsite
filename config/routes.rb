Rails.application.routes.draw do
  
  root :to =>"homes#top"
  get "/about"=>"homes#about"
  
  namespace :admin do
    root :to =>"homes#top"
  end
  
  # 顧客用
  # /customers/sign_in ...
  devise_for :customers,skip: [:passwords,], controllers: {
    registrations: "customer/registrations",
    sessions: 'customer/sessions'
  }
  
  # 管理者用
  # /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  get '/customers/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe_customer'
  patch 'customers/withdraw' => 'customers#withdraw', as: 'withdraw_customer'
  get 'customers/my_page' => 'customers#show', as: 'my_page'
  resources :customers, only: [:edit, :update]
    
 
end
