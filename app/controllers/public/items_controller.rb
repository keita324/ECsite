class Public::ItemsController < ApplicationController
    def index
        @genres = Genre.all
        if params[:genre_id]
          # Categoryのデータベースのテーブルから一致するidを取得
          @genre = Genre.find(params[:genre_id])
          # category_idと紐づくを取得
          @items = @genre.items.all
          @title = @genre.name
        else
          @items = Item.where(status: 'true')
          @title = "商品"
        end
    end 
    
    def show
      @item = Item.find(params[:id])
      @cart = CartItem.new
    end 
    
    private
      def item_params
        params.require(:item).permit(:genre_id, :image, :name, :introduction, :price_tax_out, :status)
      end
end
