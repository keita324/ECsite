class Item < ApplicationRecord
    has_one_attached :image
    belongs_to :genre
    
    validates :image, presence: true
    validates :name, presence: true
    validates :introduction, presence: true
    validates :genre_id, presence: true
    validates :price_tax_out, presence: true, format: {
    with: /\A[0-9]+\z/i,
    }
    
    def get_image(width, height)
     image.variant(resize_to_limit: [width, height]).processed
    end
end
