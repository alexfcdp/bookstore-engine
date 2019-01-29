# frozen_string_literal: true

FactoryBot.define do
  factory :order_item, class: 'ShoppingCart::OrderItem' do
    price { rand(3.5..100).round(2) }
    quantity { rand(1..100) }
    sub_total { rand(3.5..100).round(2) }
    product { create(:book) }
    order
  end
end
