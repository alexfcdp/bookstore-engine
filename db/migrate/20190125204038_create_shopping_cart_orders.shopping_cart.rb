# frozen_string_literal: true

# This migration comes from shopping_cart (originally 20190123102648)
class CreateShoppingCartOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_cart_orders do |t|
      t.string :order_number, index: { unique: true }
      t.decimal :total_price, precision: 10, scale: 2, null: false, default: 0.00
      t.integer :status, null: false, default: 0
      t.bigint :user_id, index: true
      t.bigint :delivery_id, index: true
      t.bigint :coupon_id, index: true

      t.timestamps
    end
  end
end
