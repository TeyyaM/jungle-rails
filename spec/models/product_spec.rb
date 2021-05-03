require 'rails_helper'

RSpec.describe Product, type: :model do
    # pending 'add some examples to (or delete) #{__FILE__}'
    describe 'Validations' do
      before (:all) do
        @category = Category.new(name: 'test_category')
        @category.save!
      end

      context 'A new product' do 
        context 'before being saved' do
          it 'should not have an id' do
            @product = Product.new
            expect(@product.id).to be_nil
          end
        end

        context 'with all attributes' do
        it 'saves to the database' do
          @product = Product.new(
            name: 'test name', 
            description: 'test description', 
            image: 'test.jpg',
            quantity: 20,
            price: 99.99,
            category: @category
          )
        
          @product.save!
          expect(@product.errors.full_messages[0]).to be_nil
          expect(@product.id).to be_present
        end
      end

      context 'with no image' do
        it 'saves to the database' do
          @product = Product.new( 
            name: 'test name', 
            description: 'test description', 
            quantity: 20,
            price: 99.99,
            category: @category
          )
          
          @product.save
          expect(@product.errors.full_messages[0]).to be_nil
          expect(@product.id).to be_present
        end
      end
      
      context 'with no name' do
        it 'does not save to the database' do
          @product = Product.new( 
            description: 'test description', 
            image: 'test.jpg',
            quantity: 20,
            price: 99.99,
            category: @category
          )
          
          @product.save

          expect(@product.errors.full_messages[0]).to eq('Name can\'t be blank')
          expect(@product.id).not_to be_present
        end
      end
    end
  end
end
