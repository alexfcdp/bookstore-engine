# frozen_string_literal: true

# This migration comes from shopping_cart (originally 20190123104233)
class CreateShoppingCartOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_cart_order_items do |t|
      t.decimal :price, precision: 8, scale: 2, null: false, default: 0.00
      t.integer :quantity, null: false, default: 0
      t.decimal :sub_total, precision: 8, scale: 2, null: false, default: 0.00
      t.bigint :product_id, index: true
      t.bigint :order_id, index: true

      t.timestamps
    end
  end
end
