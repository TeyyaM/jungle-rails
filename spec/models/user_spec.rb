require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    before(:each) do
      @user = User.new(
        first_name: 'Egg',
        last_name: 'Eggerson',
        email: 'egg@egg.com',
        password: 'egg',
        password_confirmation: 'egg'
      )
    end
    context 'A new user' do
      context 'will all valid parameters' do
        it 'should save' do
          @user.save!
          expect(@user.errors.full_messages[0]).to be_nil
          expect(@user.id).not_to be_nil
        end
      end

      context 'with no first name' do
        it 'does not save to the database' do
          @user[:first_name] = nil
          @user.save
          expect(@user.errors.full_messages[0]).to eq('First name can\'t be blank')
          expect(@user.id).to be_nil
        end
      end

      context 'with no last name' do
        it 'does not save to the database' do
          @user[:last_name] = nil
          @user.save
          expect(@user.errors.full_messages[0]).to eq('Last name can\'t be blank')
          expect(@user.id).to be_nil
        end
      end

      context 'in regards to emails' do
        before(:each) do
          @user2 = User.new(
            first_name: 'Egg',
            last_name: 'Eggerson',
            email: 'egg@egg.com',
            password: 'egg',
            password_confirmation: 'egg'
          )
        end

        context 'with an already registered email' do
          it 'does not save to the database' do
            @user.save
            @user2.save
            expect(@user2.errors.full_messages[0]).to eq('Email has already been taken')
            expect(@user2.id).to be_nil
          end
        end

        context 'with an already registered email regardless of capitalization' do
          it 'does not save to the database' do
            @user.save
            @user2[:email] = 'EGG@EGG.COM'
            @user2.save
            expect(@user2.errors.full_messages[0]).to eq('Email has already been taken')
            expect(@user2.id).to be_nil
          end
        end
      end

      context 'with no password' do
        it 'does not save to the database' do
          @user = User.new(
            first_name: 'Egg',
            last_name: 'Eggerson',
            email: 'egg@egg.com',
            password_confirmation: 'egg'
          )
          @user.save
          expect(@user.errors.full_messages[0]).to eq('Password can\'t be blank')
          expect(@user.id).to be_nil
        end
      end

      context 'with no password confirmation' do
        it 'does not save to the database' do
          @user = User.new(
            first_name: 'Egg',
            last_name: 'Eggerson',
            email: 'egg@egg.com',
            password: 'egg'
          )
          @user.save
          expect(@user.errors.full_messages[0]).to eq('Password confirmation can\'t be blank')
          expect(@user.id).to be_nil
        end
      end

      context 'with non-identical password and password confirmation' do
        it 'does not save to the database' do
          @user = User.new(
            first_name: 'Egg',
            last_name: 'Eggerson',
            email: 'egg@egg.com',
            password: 'egg',
            password_confirmation: 'EGG'
          )
          @user.save
          expect(@user.errors.full_messages[0]).to eq('Password confirmation doesn\'t match Password')
          expect(@user.id).to be_nil
        end
      end
    end 
  end

  describe '.authenticate_with_credentials' do
    before(:each) do
      @user = User.new(
        first_name: 'Egg',
        last_name: 'Eggerson',
        email: 'egg@egg.com',
        password: 'egg',
        password_confirmation: 'egg'
      )
      @user.save
    end

    context 'An attempt to authenticate' do
      context 'with a valid email and password' do
        it 'will return the user' do
        expect(User.authenticate_with_credentials('egg@egg.com', 'egg')).to eql(@user)
        end
      end 
      context 'with a valid email with trailing whitespace or capitalization and valid password' do
        it 'will return the user' do
        expect(User.authenticate_with_credentials('  EgG@eGG.cOm    ', 'egg')).to eql(@user)
        end
      end 

      context 'with an invalid email' do
      it 'will return nil' do
      expect(User.authenticate_with_credentials('ham@ham.com', 'egg')).to be_nil
      end
    end 

    context 'with an invalid password' do
      it 'will return nil' do
      expect(User.authenticate_with_credentials('egg@egg.com', 'greeneggs')).to be_nil
      end
    end 
    end
  end

end
