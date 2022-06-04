require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do

  before do
    @user = FactoryBot.build(:user)
    @admin_user = FactoryBot.create(:user)
    @admin_user.add_role :admin
    @general_user = FactoryBot.create(:user)
    @general_user.add_role :editor
  end

  context 'ユーザー新規登録ができるとき' do 

    it '管理者ユーザーが正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # 管理者ユーザーでログインする
      visit new_user_session_path
      fill_in '社員番号', with: @admin_user.employee_number
      fill_in 'パスワード', with: @admin_user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ユーザー管理ページに移動する
      visit users_index_path
      # ユーザー管理ページに新規登録ページに遷移するボタンが存在する
      expect(page).to have_content('新規登録')
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in '社員番号', with: @user.employee_number
      fill_in 'パスワード', with: @user.password
      fill_in 'パスワード(再入力)', with: @user.password_confirmation
      fill_in '氏名', with: @user.name
      select '管理者ユーザー', from: 'user[admin_id]'
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # メニュー画面へ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # 「ユーザーを新規登録しました」の文字があることを確認する
      expect(page).to have_content('ユーザーを新規登録しました')
      # ユーザー管理ページに移動する
      visit users_index_path
      # ユーザー一覧に先ほど登録したユーザーが存在することを確認する
      expect(page).to have_content(@user.name)
    end

  end


 
end
