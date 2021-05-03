require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:all) do
      @category = Category.new(name: 'test_category')
      @category.save!
    end
    
    before(:each) do
      @product = Product.new(
        name: 'test name',
        quantity: 20,
        price: 99.99,
        category: @category
      )
    end

    context 'A new product' do
      context 'before being saved' do
        it 'should not have an id' do
          expect(@product.id).to be_nil
        end
      end

      context 'with all required attributes' do
        it 'saves to the database' do
          @product.save!
          expect(@product.errors.full_messages[0]).to be_nil
          expect(@product.id).to be_present
        end
      end

      context 'with no name' do
        it 'does not save to the database' do
          @product[:name] = nil
          @product.save
          expect(@product.errors.full_messages[0]).to eq('Name can\'t be blank')
          expect(@product.id).to be_nil
        end
      end

      context 'with no quantity' do
        it 'does not save to the database' do
          @product[:quantity] = nil
          @product.save
          expect(@product.errors.full_messages[0]).to eq('Quantity can\'t be blank')
          expect(@product.id).to be_nil
        end
      end

      context 'with no price' do
        it 'does not save to the database' do
          @product[:price_cents] = nil
          @product.save
          expect(@product.errors.full_messages[0]).to eq('Price cents is not a number')
          expect(@product.id).to be_nil
        end
      end

      context 'with no category' do
        it 'does not save to the database' do
          @product[:category_id] = nil
          @product.save
          expect(@product.errors.full_messages[0]).to eq('Category can\'t be blank')
          expect(@product.id).to be_nil
        end
      end
    end
  end
end
