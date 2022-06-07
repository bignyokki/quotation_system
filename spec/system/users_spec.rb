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

  context 'ユーザー新規登録ができないとき' do

    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
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
      fill_in '社員番号', with: ''
      fill_in 'パスワード', with: ''
      fill_in 'パスワード(再入力)', with: ''
      fill_in '氏名', with: ''
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq user_registration_path
    end

    it '一般ユーザーではユーザー新規登録ができない' do
      # 一般ユーザーでログインする
      visit new_user_session_path
      fill_in '社員番号', with: @general_user.employee_number
      fill_in 'パスワード', with: @general_user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ユーザー管理ページに移動する
      visit users_index_path
      # ユーザー管理ページに新規登録ページに遷移するボタンが存在しない
      expect(page).to have_no_content('新規登録')
      # 直接新規登録ページに移動しても、メニュー画面に戻される
      visit new_user_registration_path
      expect(current_path).to eq(root_path)
      expect(page).to have_content('画面を閲覧する権限がありません。')
    end

    it 'ログインしないとユーザー新規登録出来ない' do
      # ユーザー新規登録ページに移動しようとするとログイン画面に遷移することを確認する
      visit new_user_registration_path
      expect(current_path).to eq(new_user_session_path)
      # 「アプリにアクセスするためにはログインしてください」の文字が存在することを確認する
      expect(page).to have_content('アプリにアクセスするためにはログインしてください')
    end

  end

end


RSpec.describe 'ユーザー情報削除', type: :system do

  before do
    @user = FactoryBot.create(:user)
    @admin_user = FactoryBot.create(:user)
    @admin_user.add_role :admin
    @general_user = FactoryBot.create(:user)
    @general_user.add_role :editor
  end

  context 'ユーザー情報を削除できるとき' do

    it '管理者ユーザーはユーザーの情報を編集できる' do
      # 管理者ユーザーでログインする
      visit new_user_session_path
      fill_in '社員番号', with: @admin_user.employee_number
      fill_in 'パスワード', with: @admin_user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ユーザー管理ページに移動する
      visit users_index_path
      # 削除ボタンが存在することを確認する
      expect(page).to have_content('削除')
      # 削除ボタンを押すとレコードの数が１減ることを確認する
      expect{
        find_link('削除', href: destroy_other_user_registration_path(@user)).click
      }.to change { User.count }.by(-1)
      # 「ユーザーを削除しました」の文章があることを確認する
      expect(page).to have_content('ユーザーを削除しました')
      # ユーザー管理ページに削除したユーザーの情報がないことを確認する
      expect(page).to have_no_content("#{@user.name}")
    end

  end

  context 'ユーザーの削除ができないとき' do

    it '一般ユーザーはユーザーの削除ができない' do
      # 一般ユーザーでログインする
      visit new_user_session_path
      fill_in '社員番号', with: @general_user.employee_number
      fill_in 'パスワード', with: @general_user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # ユーザー管理ページに移動する
      visit users_index_path
      # ユーザー管理ページに新規登録ページに遷移するボタンが存在しない
      expect(page).to have_no_content('削除')
    end

  end

end