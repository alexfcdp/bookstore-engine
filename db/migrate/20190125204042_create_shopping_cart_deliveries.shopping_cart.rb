# frozen_string_literal: true

# This migration comes from shopping_cart (originally 20190123135406)
class CreateShoppingCartDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_cart_deliveries do |t|
      t.string :name
      t.string :terms
      t.decimal :price, precision: 6, scale: 2

      t.timestamps
    end
  end
end
