class Public::CartItemsController < ApplicationController
    def index
        @cart_items = current_customer.cart_items
    end 
    
    def update
        @cart = CartItem.find(params[:id])
        @cart.update(cart_item_params)
        redirect_to cart_items_path
    end 
    
    def destroy
        @cart = CartItem.find(params[:id])
        @cart.destroy
        redirect_to cart_items_path
    end 
    
    def destroy_all
        @cart_items = current_customer.cart_items
        @cart_items.destroy_all
        redirect_to cart_items_path
    end 
    
    def create
        @cart = CartItem.new(cart_item_params)
        @cart.customer_id = current_customer.id
        @current_cart = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
        
        if @current_cart.present?
            @current_cart.amount = @current_cart.amount + @cart.amount
            @current_cart.save
        else
            @cart.save
        end
        redirect_to cart_items_path
    end 
    
    private
     def cart_item_params
        params.require(:cart_item).permit(:customer_id, :item_id, :amount)
     end 
     
     
end
