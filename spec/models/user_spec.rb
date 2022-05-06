require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do

    context '新規登録できる場合' do
      it 'nickname、email、password、password_confirmation、last_name、first_name、last_name_kana、first_name_kana、birthdayが存在するため登録できる' do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it 'nicknameが存在しないため登録できない' do
        @user.nickname = ''
        @user.invalid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが存在しないため登録できない' do
        @user.email = ''
        @user.invalid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'emailが重複しているため登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.invalid?
        expect(another_user.errors.full_messages).to include("Email has already been taken")
      end
      it 'emailに@が含まれていないため登録できない' do
        @user.email = 'testtest'
        @user.invalid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'passwordが存在しないため登録できない' do
        @user.password = ''
        @user.invalid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'passwordが5文字以下のため登録できない' do
        @user.password = 'aaaaa'
        @user.invalid?
        expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
      end
      it 'passwordが129文字以上のため登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.invalid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end
      it 'passwordが半角英数を両方含んでいないため登録できない' do
        @user.password = 'testtest'
        @user.invalid?
        expect(@user.errors.full_messages).to include("Password is invalid")
      end
      it 'passwordとpaasowrd_confirmationが一致しないため登録できない' do
        @user.password = '1234567'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'password_confirmationが存在しないため登録できない' do
        @user.password_confirmation = ''
        @user.invalid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'last_nameが存在しないため登録できない' do
        @user.last_name = ''
        @user.invalid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'last_nameが全角（漢字・ひらがな・カタカナ）でないため登録できない' do
        @user.last_name = 'testtest'
        @user.invalid?
        expect(@user.errors.full_messages).to include("Last name is invalid")
      end
      it 'first_nameが存在しないため登録できない' do
        @user.first_name = ''
        @user.invalid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'first_nameが全角（漢字・ひらがな・カタカナ）でないため登録できない' do
        @user.first_name = 'testtest'
        @user.invalid?
        expect(@user.errors.full_messages).to include("First name is invalid")
      end
      it 'last_name_kanaが存在しないため登録できない' do
        @user.last_name_kana = ''
        @user.invalid?
        expect(@user.errors.full_messages).to include("Last name kana can't be blank")
      end
      it 'last_name_kanaが全角（カタカナ）でないため登録できない' do
        @user.last_name_kana = 'ああああ'
        @user.invalid?
        expect(@user.errors.full_messages).to include("Last name kana is invalid")
      end
      it 'first_name_kanaが存在しないため登録できない' do
        @user.first_name_kana = ''
        @user.invalid?
        expect(@user.errors.full_messages).to include("First name kana can't be blank")
      end
      it 'first_name_kanaが全角（カタカナ）でないため登録できない' do
        @user.first_name_kana = 'ああああ'
        @user.invalid?
        expect(@user.errors.full_messages).to include("First name kana is invalid")
      end
    end

  end

end
