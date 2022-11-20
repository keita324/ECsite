class Admin::OrdersController < ApplicationController
    def show
        @order = Order.find(params[:id])
        @customer = @order.customer
        @order_details = @order.order_details
        @sum = 0
        @subtotals = @order_details.map { |order_detail| order_detail.item.with_tax_price * order_detail.amount }
        @sum = @subtotals.sum
    end
    
    def update
        @order = Order.find(params[:id])
        @order.update(order_params)
        order_details = @order.order_details
        
        if @order.order_status == "confirm_payment"
        #   order_details.each do |order_detail|
        #     order_details.update(product_status: "waiting")
        #   end
           
           order_details.update_all(product_status: "waiting")
        end
        
        redirect_to admin_order_path(@order.id)
    end
    
    
    private
    def order_params
        params.require(:order).permit(:order_status)
    end
    
    def order_detail_params
        params.require(:order_detail).permit(:product_status)
    end
    
    
end
