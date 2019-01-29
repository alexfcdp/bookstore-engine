# frozen_string_literal: true

FactoryBot.define do
  factory :country, class: 'ShoppingCart::Country' do
    name { FFaker::UniqueUtils.new(FFaker::Address.country, 1) }
    sequence(:phone_code) { |i| "+#{i}" }
  end
end
