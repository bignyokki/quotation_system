require 'rails_helper'

RSpec.describe '顧客新規登録', type: :system do
  before do
    @admin_user = FactoryBot.create(:user)
    @admin_user.add_role :admin
    @general_user = FactoryBot.create(:user)
    @general_user.add_role :editor
    @client =FactoryBot.build(:client)
  end

  context '顧客新規登録ができるとき' do 

    it '正しい情報を入力すれば顧客新規登録ができる' do
      # 管理者ユーザーでログインする
      visit new_user_session_path
      fill_in '社員番号', with: @admin_user.employee_number
      fill_in 'パスワード', with: @admin_user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 顧客管理ページに移動する
      visit clients_path
      # 顧客管理ページに新規登録ボタンが存在するのを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページに移動する
      visit new_client_path
      # 顧客情報を入力する
      fill_in '顧客名', with: @client.name
      fill_in 'ふりがな', with: @client.name_kana
      fill_in '電話番号', with: @client.phone_number
      fill_in 'FAX番号', with: @client.fax_number
      fill_in 'E-mail', with: @client.email
      fill_in '郵便番号', with: @client.postal_code
      # 保存ボタンを押すとclientsモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Client.count }.by(1)
      # 新規登録ページにリダイレクトされ「顧客登録を完了しました」の文字があることを確認する
      expect(current_path).to eq(new_client_path)
      expect(page).to have_content('顧客登録を完了しました')
      # 顧客一覧ページに遷移する
      visit clients_path
      #顧客一覧に登録した顧客が存在することを確認する
      expect(page).to have_content(@client.name)
    end

  end

  context '顧客新規登録ができないとき' do

    it '誤った情報では新規顧客登録はできない' do
      # 管理者ユーザーでログインする
      visit new_user_session_path
      fill_in '社員番号', with: @admin_user.employee_number
      fill_in 'パスワード', with: @admin_user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 顧客管理ページに移動する
      visit clients_path
      # 顧客管理ページに新規登録ボタンが存在するのを確認する
      expect(page).to have_content('新規登録')
      # 新規登録ページに移動する
      visit new_client_path
      # 顧客情報を入力する
      fill_in '顧客名', with: ''
      fill_in 'ふりがな', with: ''
      fill_in '電話番号', with: ''
      fill_in 'FAX番号', with: ''
      fill_in 'E-mail', with: ''
      fill_in '郵便番号', with: ''
      # 保存ボタンを押すとclientsモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Client.count }.by(0)
      # 新規登録ページにもどされ「Name can't be blank」の文字があることを確認する
      expect(page).to have_content("Name can't be blank")
    end

    it '一般ユーザーでは新規顧客登録はできない' do
      # 一般ユーザーでログインする
      visit new_user_session_path
      fill_in '社員番号', with: @general_user.employee_number
      fill_in 'パスワード', with: @general_user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 顧客管理ページに移動する
      visit clients_path
      # 顧客管理ページに新規登録ボタンが存在しないのを確認する
      expect(page).to have_no_content('新規登録')
      # 直接新規登録ページに行こうとしても、遷移できない
      visit new_client_path
      expect(current_path).to eq(root_path)
      # 「画面を閲覧する権限がありません。」の文字が存在することを確認する
      expect(page).to have_content('画面を閲覧する権限がありません。')
    end

  end

end

