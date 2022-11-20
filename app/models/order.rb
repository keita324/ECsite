class Order < ApplicationRecord
    enum payment_method: { credit_card: 0, transfer: 1 }
    enum order_status: { before_payment: 0, confirm_payment: 1, making: 2, before_sending: 3, sent: 4 }
    has_many :order_details
    belongs_to :customer
end
