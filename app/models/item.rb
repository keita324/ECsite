class Item < ApplicationRecord
    has_one_attached :image
    belongs_to :genre
    has_many :cart_items, dependent: :destroy
    ##なぜitemにhas manyがつくかというと、itemのidがcart_itemsの複数のテーブルに入っていくため
    has_many :order_details, dependent: :destroy
    
    validates :name, presence: true
    validates :introduction, presence: true
    validates :genre_id, presence: true
    validates :price_tax_out, presence: true, format: {
    with: /\A[0-9]+\z/i,
    }
    
    def get_image(width, height)
      unless image.attached?
        file_path = Rails.root.join('app/assets/images/no-image.jpg')
        image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
      end
      image.variant(resize_to_limit: [width, height]).processed
    end
    
    def with_tax_price
      (price_tax_out * 1.1).floor
    end
    
    
end
