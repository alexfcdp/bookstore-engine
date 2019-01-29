# frozen_string_literal: true

# This migration comes from shopping_cart (originally 20190124080334)
class CreateShoppingCartCountries < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_cart_countries do |t|
      t.string :name, index: { unique: true }
      t.string :phone_code, index: { unique: true }

      t.timestamps
    end
  end
end
