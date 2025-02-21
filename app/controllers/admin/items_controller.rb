class Admin::ItemsController < ApplicationController
    def index
      @items = Item.all
      if params[:name].present?
      @items = @items.get_by_name params[:name]
      end
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
         render 'new'
        end
    end

    def show
      @item = Item.find(params[:id])
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
