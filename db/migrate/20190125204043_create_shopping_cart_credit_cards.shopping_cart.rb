# frozen_string_literal: true

# This migration comes from shopping_cart (originally 20190123135530)
class CreateShoppingCartCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_cart_credit_cards do |t|
      t.string :number
      t.string :card_owner
      t.string :expiry_date
      t.bigint :order_id, index: true

      t.timestamps
    end
  end
end
