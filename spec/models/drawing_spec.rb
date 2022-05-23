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

    context '新規登録できないとき' do

      it 'figure_numberが空では登録できない' do
        @drawing.figure_number = ''
        @drawing.valid?
        expect(@drawing.errors.full_messages).to include "Figure number can't be blank"
      end

      it 'surface_treatmentが空では登録できない' do
        @drawing.surface_treatment = ''
        @drawing.valid?
        expect(@drawing.errors.full_messages).to include "Surface treatment can't be blank"
      end


      it 'quantityが空では登録できない' do
        @drawing.quantity = ''
        @drawing.valid?
        expect(@drawing.errors.full_messages).to include "Quantity can't be blank"
      end

      it 'quantityが数値以外では登録できない' do
        @drawing.quantity = 'abc'
        @drawing.valid?
        expect(@drawing.errors.full_messages).to include "Quantity is not a number"
      end


      it 'priceが空では登録できない' do
        @drawing.price = ''
        @drawing.valid?
        expect(@drawing.errors.full_messages).to include "Price can't be blank"
      end

      it 'priceが数値以外では登録できない' do
        @drawing.price = 'abc'
        @drawing.valid?
        expect(@drawing.errors.full_messages).to include "Price is not a number"
      end

    end

  end

end
