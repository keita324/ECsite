class CreateOrders < ActiveRecord::Migration[6.1]
  def change
    create_table :orders do |t|
      t.integer :customer_id
      t.string :postal_code
      t.string :address
      t.string :name
      t.integer :payment_method, default: 0, null: false
      t.integer :total_price
      t.integer :postage
      t.integer :order_status, default: 0, null: false
      t.timestamps
    end
  end
end
