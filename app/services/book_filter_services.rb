# frozen_string_literal: true

class BookFilterServices
  LIMIT_BOOKS = 12

  def initialize(params)
    @params = params
  end

  def catalog_with_category
    books = catalog.call(Book)
    @count_books = books.count
    books.send(sort).limit(paginates_per).decorate
  end

  def per_page
    amount = show_more_books
    amount < @count_books ? amount : @count_books
  end

  def disable_button?
    paginates_per >= @count_books
  end

  def sort_by
    I18n.t('filter_book').fetch(sort.to_sym)
  end

  private

  def catalog
    lambda do |object|
      return object if category.blank?

      object.books_category(category)
    end
  end

  def category
    @params[:category]
  end

  def paginates_per
    return @params[:per].to_i if @params[:per] && @params[:per].to_i >= 1

    LIMIT_BOOKS
  end

  def sort
    return @params[:sort] if @params[:sort] && I18n.t('filter_book').include?(@params[:sort].to_sym)

    I18n.t('filter_book').keys[4]
  end

  def show_more_books
    paginates_per == LIMIT_BOOKS ? LIMIT_BOOKS * 2 : paginates_per + LIMIT_BOOKS
  end
end
