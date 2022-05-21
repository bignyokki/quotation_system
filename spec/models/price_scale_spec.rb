require 'rails_helper'

RSpec.describe PriceScale, type: :model do

  before do
    @price_scale = FactoryBot.build(:price_scale)
  end

  describe '顧客新規登録' do

    context '新規登録できる時' do

      it '必要な項目を正しく入力すれば登録できる' do
        expect(@price_scale).to be_valid
      end
      it '重量の単価が空でも面積の単価が入力されれば登録できる' do
        @price_scale.scale_w_0_3 = ''
        @price_scale.scale_w_3_6 = ''
        @price_scale.scale_w_6_11 = ''
        @price_scale.scale_w_11_15 = ''
        @price_scale.scale_w_15_22 = ''
        @price_scale.scale_w_22_30 = ''
        @price_scale.scale_w_50_80 = ''
        @price_scale.scale_w_80_150 = ''
        @price_scale.scale_w_150_180 = ''
        @price_scale.scale_w_180over = ''
        expect(@price_scale).to be_valid
      end
      it '面積の単価が空でも重量の単価が入力されれば登録できる' do
        @price_scale.scale_a_0_3 = ''
        @price_scale.scale_a_3_6 = ''
        @price_scale.scale_a_6_11 = ''
        @price_scale.scale_a_11_15 = ''
        @price_scale.scale_a_15_22 = ''
        @price_scale.scale_a_22_30 = ''
        @price_scale.scale_a_50_80 = ''
        @price_scale.scale_a_80_150 = ''
        @price_scale.scale_a_150_180 = ''
        @price_scale.scale_a_180over = ''
        expect(@price_scale).to be_valid
      end

    end


    context '新規登録できないとき' do

      it 'titleが空では登録できない' do
        @price_scale.title = ''
        @price_scale.valid?
        expect(@price_scale.errors.full_messages).to include "Title can't be blank"
      end

      it 'surface_treatmentが空では登録できない' do
        @price_scale.surface_treatment = ''
        @price_scale.valid?
        expect(@price_scale.errors.full_messages).to include "Surface treatment can't be blank"
      end

      it '面積と重量が両方空では登録できない' do
        @price_scale.scale_w_0_3 = ''
        @price_scale.scale_a_0_3 = ''
        @price_scale.valid?
        expect(@price_scale.errors.full_messages).to include "Scale w 0 3 can't be blank", "Scale a 0 3 can't be blank"
      end
      it 'scale_w_0_3が入力されているとき、重量が空では登録できない' do
        @price_scale.scale_w_3_6 = ''
        @price_scale.scale_w_6_11 = ''
        @price_scale.scale_w_11_15 = ''
        @price_scale.scale_w_15_22 = ''
        @price_scale.scale_w_22_30 = ''
        @price_scale.scale_w_50_80 = ''
        @price_scale.scale_w_80_150 = ''
        @price_scale.scale_w_150_180 = ''
        @price_scale.scale_w_180over = ''
        @price_scale.valid?
        expect(@price_scale.errors.full_messages).to include "Scale w 3 6 can't be blank", 
                                                             "Scale w 6 11 can't be blank",
                                                             "Scale w 11 15 can't be blank", 
                                                             "Scale w 22 30 can't be blank",
                                                             "Scale w 50 80 can't be blank",
                                                             "Scale w 80 150 can't be blank",
                                                             "Scale w 150 180 can't be blank", 
                                                             "Scale w 180over can't be blank"
      end
      it 'scale_a_0_3が入力されているとき、重量が空では登録できない' do
        @price_scale.scale_a_3_6 = ''
        @price_scale.scale_a_6_11 = ''
        @price_scale.scale_a_11_15 = ''
        @price_scale.scale_a_15_22 = ''
        @price_scale.scale_a_22_30 = ''
        @price_scale.scale_a_50_80 = ''
        @price_scale.scale_a_80_150 = ''
        @price_scale.scale_a_150_180 = ''
        @price_scale.scale_a_180over = ''
        @price_scale.valid?
        expect(@price_scale.errors.full_messages).to include "Scale a 3 6 can't be blank", 
                                                             "Scale a 6 11 can't be blank",
                                                             "Scale a 11 15 can't be blank", 
                                                             "Scale a 22 30 can't be blank",
                                                             "Scale a 50 80 can't be blank",
                                                             "Scale a 80 150 can't be blank",
                                                             "Scale a 150 180 can't be blank", 
                                                             "Scale a 180over can't be blank"
      end
      it 'scale_w_0_3が数値以外では登録できない' do
        @price_scale.scale_w_0_3 = 'abc'
        @price_scale.valid?
        expect(@price_scale.errors.full_messages).to include "Scale w 0 3 is not a number"
      end
      it 'scale_w_0_3が入力されているとき、重量は数値以外では登録できない' do
        @price_scale.scale_w_3_6 = 'abc'
        @price_scale.scale_w_6_11 = 'abc'
        @price_scale.scale_w_11_15 = 'abc'
        @price_scale.scale_w_15_22 = 'abc'
        @price_scale.scale_w_22_30 = 'abc'
        @price_scale.scale_w_50_80 = 'abc'
        @price_scale.scale_w_80_150 = 'abc'
        @price_scale.scale_w_150_180 = 'abc'
        @price_scale.scale_w_180over = 'abc'
        @price_scale.valid?
        expect(@price_scale.errors.full_messages).to include "Scale w 3 6 is not a number", 
                                                             "Scale w 6 11 is not a number",
                                                             "Scale w 11 15 is not a number", 
                                                             "Scale w 22 30 is not a number",
                                                             "Scale w 50 80 is not a number",
                                                             "Scale w 80 150 is not a number",
                                                             "Scale w 150 180 is not a number", 
                                                             "Scale w 180over is not a number"
      end
      it 'scale_a_0_3が数値以外では登録できない' do
        @price_scale.scale_a_0_3 = 'abc'
        @price_scale.valid?
        expect(@price_scale.errors.full_messages).to include "Scale a 0 3 is not a number"
      end
      it 'scale_a_0_3が入力されているとき、重量は数値以外では登録できない' do
        @price_scale.scale_a_3_6 = 'abc'
        @price_scale.scale_a_6_11 = 'abc'
        @price_scale.scale_a_11_15 = 'abc'
        @price_scale.scale_a_15_22 = 'abc'
        @price_scale.scale_a_22_30 = 'abc'
        @price_scale.scale_a_50_80 = 'abc'
        @price_scale.scale_a_80_150 = 'abc'
        @price_scale.scale_a_150_180 = 'abc'
        @price_scale.scale_a_180over = 'abc'
        @price_scale.valid?
        expect(@price_scale.errors.full_messages).to include "Scale a 3 6 is not a number", 
                                                             "Scale a 6 11 is not a number",
                                                             "Scale a 11 15 is not a number", 
                                                             "Scale a 22 30 is not a number",
                                                             "Scale a 50 80 is not a number",
                                                             "Scale a 80 150 is not a number",
                                                             "Scale a 150 180 is not a number", 
                                                             "Scale a 180over is not a number"
      end

      it '最小単価が空では登録できない' do
        @price_scale.min_unit_price = ''
        @price_scale.valid?
        expect(@price_scale.errors.full_messages).to include "Min unit price can't be blank"
      end

      it '最小価格が空では登録できない' do
        @price_scale.min_total_price = ''
        @price_scale.valid?
        expect(@price_scale.errors.full_messages).to include "Min total price can't be blank"
      end

    end

  end

end
