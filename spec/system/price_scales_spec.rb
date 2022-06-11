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
      # 保存ボタンを押すとprice_scaleモデルのカウントが1上がることを確認する
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

  context '単価表新規登録が出来ないとき' do 

    it '誤った情報を入力しても単価表新規登録ができない' do
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
      fill_in 'タイトル', with: ''
      fill_in '処理名', with: ''
      fill_in 'price_scale[scale_a_0_3]', with: ''
      fill_in 'price_scale[scale_a_3_6]', with: ''
      fill_in 'price_scale[scale_a_6_11]', with: ''
      fill_in 'price_scale[scale_a_11_15]', with: ''
      fill_in 'price_scale[scale_a_15_22]', with: ''
      fill_in 'price_scale[scale_a_22_30]', with: ''
      fill_in 'price_scale[scale_a_30_50]', with: ''
      fill_in 'price_scale[scale_a_50_80]', with: ''
      fill_in 'price_scale[scale_a_80_150]', with: ''
      fill_in 'price_scale[scale_a_150_180]', with: ''
      fill_in 'price_scale[scale_a_180over]', with: ''
      fill_in 'price_scale[scale_w_0_3]', with: ''
      fill_in 'price_scale[scale_w_3_6]', with: ''
      fill_in 'price_scale[scale_w_6_11]', with: ''
      fill_in 'price_scale[scale_w_11_15]', with: ''
      fill_in 'price_scale[scale_w_15_22]', with: ''
      fill_in 'price_scale[scale_w_22_30]', with: ''
      fill_in 'price_scale[scale_w_30_50]', with: ''
      fill_in 'price_scale[scale_w_50_80]', with: ''
      fill_in 'price_scale[scale_w_80_150]', with: ''
      fill_in 'price_scale[scale_w_150_180]', with: ''
      fill_in 'price_scale[scale_w_180over]', with: ''
      fill_in 'price_scale[scale_o_0_300]', with: ''
      fill_in 'price_scale[scale_o_300_500]', with: ''
      fill_in 'price_scale[scale_o_500over]', with: ''
      fill_in 'price_scale[min_unit_price]', with: ''
      fill_in 'price_scale[min_total_price]', with: ''
      # 保存ボタンを押してもPriceScaleのカウントが変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { PriceScale.count }.by(0)
      # 単価表新規登録ページに戻され「Title can't be blank」の表示があることを確認する
      expect(page).to have_content("Title can't be blank")
    end

    it '一般ユーザーでは新規登録できない' do
      # 一般ユーザーでログインする
      visit new_user_session_path
      fill_in '社員番号', with: @general_user.employee_number
      fill_in 'パスワード', with: @general_user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 単価表管理ページに遷移する
      visit price_scales_path
      # 新規登録ボタンがないのを確認する
      expect(page).to have_no_content('新規登録')
      # 直接単価表新規登録ページへ移動しても、メニュー画面に遷移する
      visit new_price_scale_path
      expect(current_path).to eq(root_path)
      # 「画面を閲覧する権限がありません。」の文字が存在することを確認する
      expect(page).to have_content('画面を閲覧する権限がありません。')
    end

    it 'ログインしていないと新規登録できない' do
      # 単価表管理ページに移動しようとするとログイン画面に遷移することを確認する
      visit price_scales_path
      expect(current_path).to eq(new_user_session_path)
      # 「アプリにアクセスするためにはログインしてください」の文字が存在することを確認する
      expect(page).to have_content('アプリにアクセスするためにはログインしてください')
    end

  end

end


RSpec.describe '単価表編集', type: :system do
  before do
    @admin_user = FactoryBot.create(:user)
    @admin_user.add_role :admin
    @general_user = FactoryBot.create(:user)
    @general_user.add_role :editor
    @price_scale = FactoryBot.create(:price_scale)
  end

  context '単価表編集ができるとき' do 

    it '正しい情報を入力すれば単価表編集ができる' do
      # 管理者ユーザーでログインする
      visit new_user_session_path
      fill_in '社員番号', with: @admin_user.employee_number
      fill_in 'パスワード', with: @admin_user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 単価表管理ページに移動する
      visit price_scales_path
      # 登録された単価の編集ページへのリンクが存在することを確認する
      expect(page).to have_link '編集', href: edit_price_scale_path(@price_scale)
      # 顧客編集ページに遷移する
      visit edit_price_scale_path(@price_scale)
      # 登録された単価表情報がフォームに入っていることを確認する
      expect( find('#price_scale_title').value ).to eq(@price_scale.title.to_s)
      expect( find('#price_scale_surface_treatment').value ).to eq(@price_scale.surface_treatment.to_s)
      expect( find('#price_scale_scale_a_0_3').value ).to eq(@price_scale.scale_a_0_3.to_s)
      expect( find('#price_scale_scale_a_3_6').value ).to eq(@price_scale.scale_a_3_6.to_s)
      expect( find('#price_scale_scale_a_6_11').value ).to eq(@price_scale.scale_a_6_11.to_s)
      expect( find('#price_scale_scale_a_11_15').value ).to eq(@price_scale.scale_a_11_15.to_s)
      expect( find('#price_scale_scale_a_15_22').value ).to eq(@price_scale.scale_a_15_22.to_s)
      expect( find('#price_scale_scale_a_22_30').value ).to eq(@price_scale.scale_a_22_30.to_s)
      expect( find('#price_scale_scale_a_30_50').value ).to eq(@price_scale.scale_a_30_50.to_s)
      expect( find('#price_scale_scale_a_50_80').value ).to eq(@price_scale.scale_a_50_80.to_s)
      expect( find('#price_scale_scale_a_80_150').value ).to eq(@price_scale.scale_a_80_150.to_s)
      expect( find('#price_scale_scale_a_150_180').value ).to eq(@price_scale.scale_a_150_180.to_s)
      expect( find('#price_scale_scale_a_180over').value ).to eq(@price_scale.scale_a_180over.to_s)
      expect( find('#price_scale_scale_w_0_3').value ).to eq(@price_scale.scale_w_0_3.to_s)
      expect( find('#price_scale_scale_w_3_6').value ).to eq(@price_scale.scale_w_3_6.to_s)
      expect( find('#price_scale_scale_w_6_11').value ).to eq(@price_scale.scale_w_6_11.to_s)
      expect( find('#price_scale_scale_w_11_15').value ).to eq(@price_scale.scale_w_11_15.to_s)
      expect( find('#price_scale_scale_w_15_22').value ).to eq(@price_scale.scale_w_15_22.to_s)
      expect( find('#price_scale_scale_w_22_30').value ).to eq(@price_scale.scale_w_22_30.to_s)
      expect( find('#price_scale_scale_w_30_50').value ).to eq(@price_scale.scale_w_30_50.to_s)
      expect( find('#price_scale_scale_w_50_80').value ).to eq(@price_scale.scale_w_50_80.to_s)
      expect( find('#price_scale_scale_w_80_150').value ).to eq(@price_scale.scale_w_80_150.to_s)
      expect( find('#price_scale_scale_w_150_180').value ).to eq(@price_scale.scale_w_150_180.to_s)
      expect( find('#price_scale_scale_w_180over').value ).to eq(@price_scale.scale_w_180over.to_s)
      expect( find('#price_scale_scale_o_0_300').value ).to eq(@price_scale.scale_o_0_300.to_s)
      expect( find('#price_scale_scale_o_300_500').value ).to eq(@price_scale.scale_o_300_500.to_s)
      expect( find('#price_scale_scale_o_500over').value ).to eq(@price_scale.scale_o_500over.to_s)
      expect( find('#price_scale_min_unit_price').value ).to eq(@price_scale.min_unit_price.to_s)
      expect( find('#price_scale_min_total_price').value ).to eq(@price_scale.min_total_price.to_s)
      # 投稿内容を編集する
      fill_in 'price_scale[title]', with: "#{@price_scale.title}+編集"
      fill_in 'price_scale[surface_treatment]', with: "#{@price_scale.surface_treatment}+編集"
      fill_in 'price_scale[scale_a_0_3]', with: @price_scale.scale_a_0_3 + 10
      fill_in 'price_scale[scale_a_3_6]', with: @price_scale.scale_a_3_6 + 10
      fill_in 'price_scale[scale_a_6_11]', with: @price_scale.scale_a_6_11 + 10
      fill_in 'price_scale[scale_a_11_15]', with: @price_scale.scale_a_11_15 + 10
      fill_in 'price_scale[scale_a_15_22]', with: @price_scale.scale_a_15_22 + 10
      fill_in 'price_scale[scale_a_22_30]', with: @price_scale.scale_a_30_50 + 10
      fill_in 'price_scale[scale_a_30_50]', with: @price_scale.scale_a_22_30 + 10
      fill_in 'price_scale[scale_a_50_80]', with: @price_scale.scale_a_50_80 + 10
      fill_in 'price_scale[scale_a_80_150]', with: @price_scale.scale_a_80_150 + 10
      fill_in 'price_scale[scale_a_150_180]', with: @price_scale.scale_a_150_180 + 10
      fill_in 'price_scale[scale_a_180over]', with: @price_scale.scale_a_180over + 10
      fill_in 'price_scale[scale_w_0_3]', with: @price_scale.scale_w_0_3 + 10
      fill_in 'price_scale[scale_w_3_6]', with: @price_scale.scale_w_3_6 + 10
      fill_in 'price_scale[scale_w_6_11]', with: @price_scale.scale_w_6_11 + 10
      fill_in 'price_scale[scale_w_11_15]', with: @price_scale.scale_w_11_15 + 10
      fill_in 'price_scale[scale_w_15_22]', with: @price_scale.scale_w_15_22 + 10
      fill_in 'price_scale[scale_w_22_30]', with: @price_scale.scale_w_30_50 + 10
      fill_in 'price_scale[scale_w_30_50]', with: @price_scale.scale_w_22_30 + 10
      fill_in 'price_scale[scale_w_50_80]', with: @price_scale.scale_w_50_80 + 10
      fill_in 'price_scale[scale_w_80_150]', with: @price_scale.scale_w_80_150 + 10
      fill_in 'price_scale[scale_w_150_180]', with: @price_scale.scale_w_150_180 + 10
      fill_in 'price_scale[scale_w_180over]', with: @price_scale.scale_w_180over + 10
      fill_in 'price_scale[scale_o_0_300]', with: @price_scale.scale_o_0_300 + 10
      fill_in 'price_scale[scale_o_300_500]', with: @price_scale.scale_o_300_500 + 10
      fill_in 'price_scale[scale_o_500over]', with: @price_scale.scale_o_500over + 10
      fill_in 'price_scale[min_unit_price]', with: @price_scale.min_unit_price + 10
      fill_in 'price_scale[min_total_price]', with: @price_scale.min_total_price + 10
      # 編集してもPriceScaleモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { PriceScale.count }.by(0)
      # 顧客管理ページに遷移したことを確認する
      expect(current_path).to eq(price_scales_path)
      # 「顧客情報を編集しました」の文字が存在することを確認する
      expect(page).to have_content('単価表を編集しました')
      # 編集した内容が一覧に反映されていることを確認する
      expect(page).to have_content("#{@price_scale.title}+編集")
    end

  end

  context '単価表編集ができないとき' do 

    it '一般ユーザーは単価表新規登録ができない' do
      # 一般ユーザーでログインする
      visit new_user_session_path
      fill_in '社員番号', with: @general_user.employee_number
      fill_in 'パスワード', with: @general_user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 単価表管理ページに遷移する
      visit price_scales_path
      # 登録された単価の編集ページへのリンクが存在することを確認する
      expect(page).to have_link '編集', href: edit_price_scale_path(@price_scale)
      # 顧客編集ページに遷移する
      visit edit_price_scale_path(@price_scale)
      # 保存ボタンが存在しないことを確認する
      expect(page).to have_no_content('保存')
    end

  end

end


RSpec.describe '単価表削除', type: :system do
  before do
    @admin_user = FactoryBot.create(:user)
    @admin_user.add_role :admin
    @general_user = FactoryBot.create(:user)
    @general_user.add_role :editor
    @price_scale = FactoryBot.create(:price_scale)
  end

  context '単価表削除ができるとき' do 

    it '管理者ユーザーは単価表削除ができる' do
      # 管理者ユーザーでログインする
      visit new_user_session_path
      fill_in '社員番号', with: @admin_user.employee_number
      fill_in 'パスワード', with: @admin_user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 単価表管理ページに移動する
      visit price_scales_path
      # 登録された単価の編集ページへのリンクが存在することを確認する
      expect(page).to have_link '編集', href: edit_price_scale_path(@price_scale)
      # 顧客編集ページに遷移する
      visit edit_price_scale_path(@price_scale)
      # 削除へのリンクがあることを確認する
      expect(page).to have_link '削除', href: price_scale_path(@price_scale)
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        find_link('削除', href: price_scale_path(@price_scale)).click
      }.to change { PriceScale.count }.by(-1)
      # 顧客管理ページに遷移したことを確認する
      expect(current_path).to eq(price_scales_path)
      # 「顧客情報を削除しました」の文字があることを確認する
      expect(page).to have_content('単価表を削除しました')
      # 顧客管理ページに@clientの項が存在しないことを確認する
      expect(page).to have_no_content("#{@price_scale.title}")
    end

  end

  context '単価表削除が出来ないとき' do 

    it '一般ユーザーでは単価表削除が出来ない' do
      # 一般ユーザーでログインする
      visit new_user_session_path
      fill_in '社員番号', with: @general_user.employee_number
      fill_in 'パスワード', with: @general_user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 単価表管理ページに移動する
      visit price_scales_path
      # 登録された単価の編集ページへのリンクが存在することを確認する
      expect(page).to have_link '編集', href: edit_price_scale_path(@price_scale)
      # 顧客編集ページに遷移する
      visit edit_price_scale_path(@price_scale)
      # 削除へのリンクがあることを確認する
      expect(page).to have_no_link '削除', href: price_scale_path(@price_scale)
    end

  end

end