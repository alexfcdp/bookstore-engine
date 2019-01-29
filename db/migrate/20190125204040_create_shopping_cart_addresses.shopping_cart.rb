# frozen_string_literal: true

# This migration comes from shopping_cart (originally 20190123114839)
class CreateShoppingCartAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_cart_addresses do |t|
      t.string :firstname
      t.string :lastname
      t.string :address
      t.string :city
      t.string :zip
      t.string :phone
      t.string :type
      t.bigint :country_id, index: true
      t.references :addressable, polymorphic: true, index: { name: 'index_addresses_on_addressable' }

      t.timestamps
    end
  end
end
