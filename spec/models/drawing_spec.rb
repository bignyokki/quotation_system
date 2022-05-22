require 'rails_helper'

RSpec.describe Drawing, type: :model do

  before do
    @drawing = FactoryBot.build(:drawing)
  end

  describe '顧客新規登録' do

    context '新規登録できる時' do

      it '必要な項目を正しく入力すれば登録できる' do
        expect(@drawing).to be_valid
      end

    end

  end

end
