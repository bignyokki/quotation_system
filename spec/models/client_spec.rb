require 'rails_helper'

RSpec.describe Client, type: :model do

  before do
    @client = FactoryBot.build(:client)
  end

  describe '顧客新規登録' do

    context '新規登録できる時' do

      it '必要な項目を正しく入力すれば登録できる' do
        expect(@client).to be_valid
      end
      it '電話番号が空でも登録できる' do
        @client.phone_number = ''
        expect(@client).to be_valid
      end
      it 'FAX番号が空でも登録できる' do
        @client.fax_number = ''
        expect(@client).to be_valid
      end
      it 'emailが空でも登録できる' do
        @client.email = ''
        expect(@client).to be_valid
      end
      it '郵便番号が空でも登録できる' do
        @client.postal_code = ''
        expect(@client).to be_valid
      end

    end

    context '新規登録できないとき' do

      it 'nameが空では登録できない' do
        @client.name = ''
        @client.valid?
        expect(@client.errors.full_messages).to include "Name can't be blank"
      end

      it 'name_kanaが空では登録できない' do
        @client.name_kana = ''
        @client.valid?
        expect(@client.errors.full_messages).to include "Name kana can't be blank"
      end

      
      it '電話番号に数字以外が含まれていては登録できない' do
        @client.phone_number = 'abc-123-1234'
        @client.valid?
        expect(@client.errors.full_messages).to include "Phone number is invalid"
      end
      it '電話番号にハイフンが含まれていないと登録できない' do
        @client.phone_number = '0123456789'
        @client.valid?
        expect(@client.errors.full_messages).to include "Phone number is invalid"
      end
      it '電話番号は0から始まらないと登録できない' do
        @client.phone_number = '123-123-1234'
        @client.valid?
        expect(@client.errors.full_messages).to include "Phone number is invalid"
      end
      it '電話番号は正しく桁が入力されていないと登録できない' do
        @client.phone_number = '012-123-12345'
        @client.valid?
        expect(@client.errors.full_messages).to include "Phone number is invalid"
      end

      it 'FAX番号に数字以外が含まれていては登録できない' do
        @client.fax_number = 'abc-123-1234'
        @client.valid?
        expect(@client.errors.full_messages).to include "Fax number is invalid"
      end
      it 'FAX番号にハイフンが含まれていないと登録できない' do
        @client.fax_number = '0123456789'
        @client.valid?
        expect(@client.errors.full_messages).to include "Fax number is invalid"
      end
      it 'FAX番号は0から始まらないと登録できない' do
        @client.fax_number = '123-123-1234'
        @client.valid?
        expect(@client.errors.full_messages).to include "Fax number is invalid"
      end
      it 'FAX番号は正しく桁が入力されていないと登録できない' do
        @client.fax_number = '012-123-12345'
        @client.valid?
        expect(@client.errors.full_messages).to include "Fax number is invalid"
      end

      it 'emailは@が含まれていないと登録できない' do
        @client.email = 'abc.abc.com'
        @client.valid?
        expect(@client.errors.full_messages).to include "Email is invalid"
      end
      it 'emailは指定の記号以外が含まれていると登録できない' do
        @client.email = 'abc@abc?.com'
        @client.valid?
        expect(@client.errors.full_messages).to include "Email is invalid"
      end

      it '郵便番号は数字以外が含まれていると登録できない' do
        @client.postal_code = 'abc-1234'
        @client.valid?
        expect(@client.errors.full_messages).to include "Postal code is invalid"
      end
      it '郵便番号は正しく桁を入力しないと登録できない' do
        @client.postal_code = '12-12345'
        @client.valid?
        expect(@client.errors.full_messages).to include "Postal code is invalid"
      end
      it '郵便番号はハイフンがないと登録できない' do
        @client.postal_code = '1234567'
        @client.valid?
        expect(@client.errors.full_messages).to include "Postal code is invalid"
      end

    end

  end

end
