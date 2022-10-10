class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.integer :genre_id
      t.string :name
      t.text :introduction
      t.integer :price_tax_out
      t.boolean :status, null: false, default: true

      t.timestamps
    end
  end
end
