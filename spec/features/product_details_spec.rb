require 'rails_helper'

RSpec.feature "Visitor navigates from home page to product detail page", type: :feature do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      Product.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99,
        category: @category
      )
    end
  end
  
  scenario "They click on a product." do
    # ACT
    visit root_path
    click_link('Details', match: :first)
    
    # DEBUG
    # sleep 1
    # save_screenshot 'test_two_product_details_page.png'

    # VERIFY
    expect(page).to have_current_path(product_path(id: 10))
    expect(page).to have_text 'Quantity', count: 1
  end
end