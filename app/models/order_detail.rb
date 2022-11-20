class OrderDetail < ApplicationRecord
    enum product_status: { before: 0, waiting: 1, making: 2, finish:3 }
    belongs_to :item
    belongs_to :order
end
