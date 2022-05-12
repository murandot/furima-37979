require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '商品購入' do
    before do
      @user = FactoryBot.create(:user)
      @item = FactoryBot.build(:item)
      @item.image = fixture_file_upload('public/images/test_image.jpg')
      @item.save
      @order_address = FactoryBot.build(:order_address, user_id: @user.id, item_id: @item.id)
      sleep 0.1
    end
  
    context '商品を購入できる場合' do
      it '全て入力されているため購入できる' do
        expect(@order_address).to be_valid
      end
      it 'building_nameが存在しなくても購入できる' do
        @order_address.building_name = ''
        expect(@order_address).to be_valid
      end
    end
    context '商品を購入できない場合' do
      it 'postal_codeが空のため購入できない' do
        @order_address.postal_code = ''
        @order_address.invalid?
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeにハイフン（-）を含まれていないため購入できない' do
        @order_address.postal_code = '1234567'
        @order_address.invalid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid")
      end
      it 'postal_codeが全角数字で入力されているため購入できない' do
        @order_address.postal_code = '１２３-４５６７'
        @order_address.invalid?
        expect(@order_address.errors.full_messages).to include("Postal code is invalid")
      end
      it 'prefecture_idが空のため購入できない' do
        @order_address.prefecture_id = ''
        @order_address.invalid?
        expect(@order_address.errors.full_messages).to include("Prefecture is not a number")
      end
      it 'prefecture_idが未選択（---）のため購入できない' do
        @order_address.prefecture_id = 1
        @order_address.invalid?
        expect(@order_address.errors.full_messages).to include("Prefecture must be other than 1")
      end
      it 'cityが空のため購入できない' do
        @order_address.city = ''
        @order_address.invalid?
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end
      it 'house_numberが空のため購入できない' do
        @order_address.house_number = ''
        @order_address.invalid?
        expect(@order_address.errors.full_messages).to include("House number can't be blank")
      end
      it 'phone_numberが空のため購入できない' do
        @order_address.phone_number = ''
        @order_address.invalid?
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが9桁以下のため購入できない' do
        @order_address.phone_number = '123456789'
        @order_address.valid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end
      it 'phone_numberが12桁以上のため購入できない' do
        @order_address.phone_number = '123456789000'
        @order_address.invalid?
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end
      it 'user_idが紐づいていないため購入できない' do
        @order_address.user_id = nil
        @order_address.invalid?
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが紐づいていないため購入できない' do
        @order_address.item_id = nil
        @order_address.invalid?
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end
