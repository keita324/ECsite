class Public::CustomersController < ApplicationController
    def show
        @customer = current_customer
    end



    def edit
        @customer = Customer.find(params[:id])
    end

    def update
        @customer = Customer.find(params[:id])
        if @customer.update(customer_params)
          redirect_to my_page_path(@customer), notice: "You have updated info successfully."
        else
          render "edit"
        end
    end

    def unsubscribe
    end

    def withdraw
        @customer = current_customer
        # is_deletedカラムをtrueに変更することにより削除フラグを立てる
        @customer.update(is_deleted: true)

        # session=ログイン idが消えるとログアウト
        reset_session
        flash[:notice] = "退会処理を実行いたしました"
        redirect_to root_path
    end

    private

      def customer_params
        params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email)
      end

end
