# frozen_string_literal: true

ActiveAdmin.register ShoppingCart::Order do
  menu priority: 5
  permit_params :order_number, :total_price, :status

  actions :index, :show, :edit, :update, :destroy

  users = -> { User.all.map { |user| [user.email, user.id] } }
  coupons = -> { ShoppingCart::Coupon.all.map { |coupon| [coupon.code, coupon.id] } }

  scope I18n.t('admin.in_progress'), :not_completed, default: true
  scope I18n.t('admin.delivered'), :delivered
  scope I18n.t('admin.canceled'), :canceled

  index do
    selectable_column
    id_column
    column I18n.t('admin.order_number') do |shopping_cart_order|
      link_to shopping_cart_order.order_number, admin_shopping_cart_order_path(shopping_cart_order)
    end
    column :total_price
    column :status
    column I18n.t('admin.completion'), &:updated_at
    actions
  end

  show do
    attributes_table do
      row :order_number
      row :total_price do |shopping_cart_order|
        number_to_currency(shopping_cart_order.total_price, unit: I18n.t('currency_sign'))
      end
      row :status
      row :user
      row :delivery
      row :coupon
      row :created_at
      row :updated_at
    end
    panel I18n.t('admin.order_item') do
      attributes_table_for shopping_cart_order.order_items do
        row :book do |item|
          a href: admin_book_path(item.product) do
            if item.product.images.attached?
              img src: image_path(url_for(item.product.images.first.variant(resize: '70x100!')))
            else
              img src: image_path(url_for('no_cover.jpg')), height: '100!'
            end
            div h5 item.product.title
          end
        end
        row :price do |item|
          number_to_currency(item.price, unit: I18n.t('currency_sign'))
        end
        row :quantity
        row :sub_total do |item|
          number_to_currency(item.sub_total, unit: I18n.t('currency_sign'))
        end
      end
    end
  end

  filter :order_number
  filter :status, as: :select, collection: ShoppingCart::Order.statuses
  filter :delivery
  filter :user, collection: users
  filter :coupon, collection: coupons
  filter :updated_at

  form do |f|
    f.inputs I18n.t('admin.status_change') do
      li I18n.t('admin.current_status') + f.shopping_cart_order.status
      if f.shopping_cart_order.status.to_sym == ShoppingCart::OrderConst::IN_PROGRESS then h2 I18n.t('admin.info_status')
      else
        f.input :status, as: :select, collection: ShoppingCart::Order.statuses.keys[-3..-1], include_blank: false
      end
    end
    f.actions
  end

  config.sort_order = AdminConst::CREATED_DESC
end
