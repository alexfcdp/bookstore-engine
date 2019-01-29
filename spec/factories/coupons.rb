# frozen_string_literal: true

FactoryBot.define do
  factory :coupon, class: 'ShoppingCart::Coupon' do
    sequence(:code) { |i| "AMAZING#{i}" }
    discount { rand(10..100) }
  end
end
