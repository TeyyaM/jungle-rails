require 'rails_helper'
require 'pp'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.new name: 'Apparel'
    @category.save!

    10.times do |n|
      @product = Product.new(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        quantity: 10,
        price: 64.99,
        category: @category
      )
      @product.save!
    end
  end

  scenario "They see all products" do
    # ACT
    visit root_path

    # DEBUG
    save_screenshot 'test_one_home_page.png'

    # VERIFY
    expect(page).to have_css 'article.product'
  end
end