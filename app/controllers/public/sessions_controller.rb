# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :customer_state, only: [:create] #このcreateに関してはdeviseで見えてないけどそこにあるものっていう認識が良いかも
  
  
  
  protected
  # 退会しているかを判断するメソッド
  def customer_state
    ## 【処理内容1】 入力されたemailからアカウントを1件取得
    @customer = Customer.find_by(email: params[:customer][:email])
    ## アカウントを取得できなかった場合、このメソッドを終了する
    return if !@customer
    ## 【処理内容2】 取得したアカウントのパスワードと入力されたパスワードが一致してるかを判別 
    # パスワードあるけど、退会してる人
    if @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted == true
      redirect_to new_customer_session_path
      
      
      
      # メモ createアクションの途中でこれが入ってくるので、createを起動させる記述とかは特に必要なし
    
    # elsif @customer.valid_password?(params[:customer][:password]) && @customer.is_deleted == false
    # # ## 【処理内容3】createアクションを作動させたいけどこれで合ってる...？
    #   redirect_to customer_session_path
      
    end
  end
end
