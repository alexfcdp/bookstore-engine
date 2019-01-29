# frozen_string_literal: true

RSpec.describe BookFilterServices do
  let!(:categories) { create_list(:category, 4) }

  it 'returns a list of books of each category' do
    categories.each do |category|
      BookFilterServices.new(category: category.title).catalog_with_category.each do |book|
        expect(book.categories).to include(category)
      end
    end
  end

  it 'sorts the books of each category by :title_desc' do
    categories.each do |category|
      books = BookFilterServices.new(category: category.title, sort: 'title_desc').catalog_with_category
      expect(books).to eq(category.books.send(:title_desc))
    end
  end

  { '': 12, '5': 5, '15': 15, '20': 20, '30': 20, '100': 20 }.each do |key, per|
    it "returns the specified number '#{key} : #{per}' of books" do
      books = BookFilterServices.new(per: key.to_s).catalog_with_category
      expect(books.count).to eq(per)
    end
  end

  context 'checks methods #per_page, #disable_button? and #sort_by ' do
    let(:books_servise) { BookFilterServices.new({}) }
    before { books_servise.catalog_with_category }

    it 'returns false if not all books are shown' do
      expect(books_servise.disable_button?).to be false
    end

    it 'returns a large number of books' do
      expect(books_servise.per_page).to eq(20)
    end

    it 'sorts books by default' do
      expect(books_servise.sort_by).to eq('Title: A - Z')
    end
  end
end
