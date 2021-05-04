require 'rails_helper'

RSpec.feature "Visitor adds item to cart from home page", type: :feature do

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
  
  scenario "They click 'Add' on a product." do
    # ACT
    visit root_path
    expect(page).to have_text ' My Cart (0)', count: 1
    click_button('Add', match: :first)
    
    # DEBUG
    # sleep 1
    # save_screenshot 'test_three_product_details_page.png'

    # VERIFY
    # expect(page).to have_current_path(product_path(id: 10))
    expect(page).to have_text ' My Cart (1)', count: 1
  end
end