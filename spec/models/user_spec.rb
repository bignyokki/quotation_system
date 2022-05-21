require 'rails_helper'

RSpec.describe User, type: :model do

  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do

    context '新規登録できる時' do

      it 'すべての項目を正しく入力すれば登録できる' do
        expect(@user).to be_valid
      end

    end

    context '新規登録できないとき' do

      it '社員番号が空では登録できない' do
        @user.employee_number = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Employee number can't be blank"
      end
      it '社員番号が数字以外では登録できない' do
        @user.employee_number = 'abcd'
        @user.valid?
        expect(@user.errors.full_messages).to include "Employee number is invalid"
      end
      it '社員番号が3文字以下では登録できない' do
        @user.employee_number = '123'
        @user.valid?
        expect(@user.errors.full_messages).to include "Employee number is invalid"
      end
      it '社員番号が5文字以上では登録できない' do
        @user.employee_number = '12345'
        @user.valid?
        expect(@user.errors.full_messages).to include "Employee number is invalid"
      end
      it '社員番号が重複していると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.employee_number = @user.employee_number
        another_user.valid?
        expect(another_user.errors.full_messages).to include "Employee number has already been taken"
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password can't be blank"
      end
      it 'passwordが7文字以下では登録できない' do
        @user.password = Faker::Lorem.characters(number: 7, min_alpha: 1, min_numeric: 1)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid"
      end
      it 'passwordが17文字以上では登録できない' do
        @user.password = Faker::Lorem.characters(number: 17, min_alpha: 1, min_numeric: 1)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid"
      end
      it 'passwordが数字だけでは登録できない' do
        @user.password = '12345678'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid"
      end
      it 'passwordが文字だけでは登録できない' do
        @user.password = 'abcdefgh'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid"
      end
      it 'passwordが全角文字が含まれた場合は登録できない' do
        @user.password = 'あいうえおかきく'
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include "Password is invalid"
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Password confirmation doesn't match Password"
      end

      it 'nameが空では登録できない' do
        @user.name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Name can't be blank"
      end

      it 'admin_idが空では登録できない' do
        @user.admin_id = ''
        @user.valid?
        expect(@user.errors.full_messages).to include "Admin can't be blank"
      end
      it 'admin_idが数字以外では登録できない' do
        @user.admin_id = 'あああ'
        @user.valid?
        expect(@user.errors.full_messages).to include "Admin is not a number"
      end
      it 'admin_idが1以下では登録できない' do
        @user.admin_id = '0'
        @user.valid?
        expect(@user.errors.full_messages).to include "Admin must be greater than or equal to 1"
      end
      it 'admin_idが2以上では登録できない' do
        @user.admin_id = '3'
        @user.valid?
        expect(@user.errors.full_messages).to include "Admin must be less than or equal to 2"
      end

    end

  end

end
