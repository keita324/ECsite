class Admin::ItemsController < ApplicationController
    def index
    end

    def new
        @item = Item.new
    end

    def create
        @item = Item.new(item_params)
        if @item.save
          redirect_to admin_items_path
        else
        #   flash[:item_created_error] = "商品情報が正常に保存されませんでした。"
          redirect_to new_admin_item_path
        end
    end

    def show
    end

    def edit
    end

    def update
    end
    
    private
      def item_params
        params.require(:item).permit(:genre_id, :image, :name, :introduction, :price_tax_out, :status)
      end
end
