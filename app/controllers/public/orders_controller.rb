class Public::OrdersController < ApplicationController
    def new
        @customer = current_customer
        @order = Order.new
        
        if @customer.cart_items.presence
            render "new"
        else
            redirect_to cart_items_path
        end
    end
    
    def confirm
        @order = Order.new ##まだcreateできてないから.new
        @order.customer_id = current_customer.id
        @order.payment_method = params[:order][:payment_method]
        @order.postage = 800
        @order.order_status = 0
        @cart_items = current_customer.cart_items
        
        if params[:order][:address_number] == "1"
            @order.postal_code = current_customer.postal_code
            @order.address = current_customer.address
            @order.name = current_customer.last_name + current_customer.first_name
            
        elsif params[:order][:address_number] == "2"
            address = Address.find(params[:order][:address_id])
            @order.postal_code = address.postal_code
            @order.address = address.address
            @order.name = address.name
            
        elsif params[:order][:address_number] == "3"
            address = Address.new
            address.customer_id = current_customer.id
            address.postal_code = params[:order][:postal_code]
            address.address = params[:order][:address]
            address.name = params[:order][:name]
            address.save
            @order.postal_code = address.postal_code
            @order.address = address.address
            @order.name = address.name
        end
            
    end
    
    def thanks
    end
    
    def create
    # 1. 確認画面から送られてきた、配送先・支払い方法を取得
        @order = Order.new(order_params)
        @order.save
    # 2. カート内の合計金額から請求金額を算出
        # @order.total_price  = 800 #送料
        # current_customer.cart_items.each do |cart_item|
        #     @order.total_price  += cart_item.item.with_tax_price * cart_item.amount
        # end
        
    # 3. 注文(Order)モデルに注文を保存
    # 4. 注文詳細(OrderDetail)モデルにカート内商品の情報をもとに保存
        current_customer.cart_items.each do |cart_item|
            @order_item = OrderDetail.new
            @order_item.item_id = cart_item.item_id
            @order_item.order_id = @order.id
            @order_item.amount = cart_item.amount
            @order_item.price_tax_in = cart_item.item.with_tax_price
            @order_item.product_status = "before" 
            #数字はデータベースで保存する用、普段は文字列で扱う
            @order_item.save
        end
    # 5. 注文者のカート内商品を全て削除
        current_customer.cart_items.destroy_all
    # 6. 購入完了画面に遷移
        redirect_to order_thanks_path
            
    
    end
    
    def index
    end
    
    def show
    end
    
    private
    def order_params
        params.require(:order).permit(:address_number, :payment_method, :address, :address_id, :name,:total_price, :postal_code, :customer_id, :postage)
    end
end
