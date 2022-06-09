require 'rails_helper'

RSpec.describe '単価表新規登録', type: :system do
  before do
    @admin_user = FactoryBot.create(:user)
    @admin_user.add_role :admin
    @general_user = FactoryBot.create(:user)
    @general_user.add_role :editor
    @price_scale = FactoryBot.build(:price_scale)
  end

  context '単価表新規登録ができるとき' do 

    it '正しい情報を入力すれば単価表新規登録ができる' do
      # 管理者ユーザーでログインする
      visit new_user_session_path
      fill_in '社員番号', with: @admin_user.employee_number
      fill_in 'パスワード', with: @admin_user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 単価表管理ページに遷移する
      visit price_scales_path
      # 新規登録ボタンがあるのを確認する
      expect(page).to have_content('新規登録')
      # 単価表新規登録ページへ遷移する
      visit new_price_scale_path
      # 単価表情報を入力する
      fill_in 'タイトル', with: @price_scale.title
      fill_in '処理名', with: @price_scale.surface_treatment
      fill_in 'price_scale[scale_a_0_3]', with: @price_scale.scale_a_0_3
      fill_in 'price_scale[scale_a_3_6]', with: @price_scale.scale_a_3_6
      fill_in 'price_scale[scale_a_6_11]', with: @price_scale.scale_a_6_11
      fill_in 'price_scale[scale_a_11_15]', with: @price_scale.scale_a_11_15
      fill_in 'price_scale[scale_a_15_22]', with: @price_scale.scale_a_15_22
      fill_in 'price_scale[scale_a_22_30]', with: @price_scale.scale_a_30_50
      fill_in 'price_scale[scale_a_30_50]', with: @price_scale.scale_a_22_30
      fill_in 'price_scale[scale_a_50_80]', with: @price_scale.scale_a_50_80
      fill_in 'price_scale[scale_a_80_150]', with: @price_scale.scale_a_80_150
      fill_in 'price_scale[scale_a_150_180]', with: @price_scale.scale_a_150_180
      fill_in 'price_scale[scale_a_180over]', with: @price_scale.scale_a_180over
      fill_in 'price_scale[scale_w_0_3]', with: @price_scale.scale_w_0_3
      fill_in 'price_scale[scale_w_3_6]', with: @price_scale.scale_w_3_6
      fill_in 'price_scale[scale_w_6_11]', with: @price_scale.scale_w_6_11
      fill_in 'price_scale[scale_w_11_15]', with: @price_scale.scale_w_11_15
      fill_in 'price_scale[scale_w_15_22]', with: @price_scale.scale_w_15_22
      fill_in 'price_scale[scale_w_22_30]', with: @price_scale.scale_w_30_50
      fill_in 'price_scale[scale_w_30_50]', with: @price_scale.scale_w_22_30
      fill_in 'price_scale[scale_w_50_80]', with: @price_scale.scale_w_50_80
      fill_in 'price_scale[scale_w_80_150]', with: @price_scale.scale_w_80_150
      fill_in 'price_scale[scale_w_150_180]', with: @price_scale.scale_w_150_180
      fill_in 'price_scale[scale_w_180over]', with: @price_scale.scale_w_180over
      fill_in 'price_scale[scale_o_0_300]', with: @price_scale.scale_o_0_300
      fill_in 'price_scale[scale_o_300_500]', with: @price_scale.scale_o_300_500
      fill_in 'price_scale[scale_o_500over]', with: @price_scale.scale_o_500over
      fill_in 'price_scale[min_unit_price]', with: @price_scale.min_unit_price
      fill_in 'price_scale[min_total_price]', with: @price_scale.min_total_price
      # 保存ボタンを押すとprice_scacleモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { PriceScale.count }.by(1)
      # 単価表管理ページに遷移されることを確認する
      expect(current_path).to eq(price_scales_path)
      # 「単価表を登録しました」と表示されることを確認する
      expect(page).to have_content('単価表を登録しました')
      # 顧客管理ページに登録した単価表が存在するのを確認する
      expect(page).to have_content(@price_scale.title)
    end

  end

end

