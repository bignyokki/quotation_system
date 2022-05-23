require 'rails_helper'

RSpec.describe Quotation, type: :model do

  before do
    @quotation = FactoryBot.build(:quotation)
  end

  describe '見積新規登録' do

    context '新規登録できる時' do

      it '必要な項目を正しく入力すれば登録できる' do
        expect(@quotation).to be_valid
      end

    end
    
  end

end
