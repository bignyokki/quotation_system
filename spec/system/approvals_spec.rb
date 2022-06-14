require 'rails_helper'

RSpec.describe '見積承認', type: :system do
  before do
    @admin_user = FactoryBot.create(:user)
    @admin_user.add_role :admin
    @general_user = FactoryBot.create(:user)
    @general_user.add_role :editor
    @quotation = FactoryBot.create(:quotation)
  end

  context '見積承認ができるとき' do 

    it '管理者ユーザーは見積承認ができる' do
      # 管理者ユーザーでログインする
      sign_in(@admin_user)
      # 見積承認待ち一覧へ遷移する
      visit approvals_path
      # 一覧の中に@quotationのリンクがあることを確認する
      expect(page).to have_link @quotation.title, href: edit_approval_path(@quotation)
      # 承認編集ページに遷移する
      visit edit_approval_path(@quotation)
      # 見積情報が入力されていることを確認する
      expect(
        find('#quotation_title').value
      ).to eq(@quotation.title)
      expect(
        find('#quotation_charge').value
      ).to eq(@quotation.charge)
      expect(
        find('#quotation_delivery_date').value
      ).to eq(@quotation.delivery_date)
      expect(
        find('#quotation_expiration_date').value
      ).to eq(@quotation.expiration_date)
      expect(
        find('#quotation_delivery_place').value
      ).to eq(@quotation.delivery_place)
      expect(
        find('#quotation_business_terms').value
      ).to eq(@quotation.business_terms)
      # 承認ボタンを押すと承認待ち一覧に遷移することを確認する
      find('input[name="approval_btn"]').click
      expect(current_path).to eq(approvals_path)
      # 「見積を承認しました」の文字が存在することを確認する
      expect(page).to have_content('見積を承認しました')
      # 承認待ち一覧に@quotationの項がなくなっていることを確認する
      expect(page).to have_no_content(@quotation.title)
      # 見積印刷待ち一覧に遷移する
      visit printings_path
      # @quotationの項が存在することを確認する
      expect(page).to have_content(@quotation.title)
    end

    it '管理者ユーザーは見積差し戻しできる' do
      # 管理者ユーザーでログインする
      sign_in(@admin_user)
      # 見積承認待ち一覧へ遷移する
      visit approvals_path
      # 一覧の中に@quotationのリンクがあることを確認する
      expect(page).to have_link @quotation.title, href: edit_approval_path(@quotation)
      # 承認編集ページに遷移する
      visit edit_approval_path(@quotation)
      # 見積情報が入力されていることを確認する
      expect(
        find('#quotation_title').value
      ).to eq(@quotation.title)
      expect(
        find('#quotation_charge').value
      ).to eq(@quotation.charge)
      expect(
        find('#quotation_delivery_date').value
      ).to eq(@quotation.delivery_date)
      expect(
        find('#quotation_expiration_date').value
      ).to eq(@quotation.expiration_date)
      expect(
        find('#quotation_delivery_place').value
      ).to eq(@quotation.delivery_place)
      expect(
        find('#quotation_business_terms').value
      ).to eq(@quotation.business_terms)
      # 承認ボタンを押すと承認待ち一覧に遷移することを確認する
      find('input[name="back_btn"]').click
      expect(current_path).to eq(approvals_path)
      # 「見積を差し戻ししました」の文字が存在することを確認する
      expect(page).to have_content('見積を差し戻ししました')
      # 承認待ち一覧に@quotationの項がなくなっていることを確認する
      expect(page).to have_no_content(@quotation.title)
      # 見積印刷待ち一覧に遷移する
      visit index2_approvals_path
      # @quotationの項が存在することを確認する
      expect(page).to have_content(@quotation.title)
    end

  end

  context '見積承認ができない時' do
    
    it '一般ユーザーは見積承認できない' do
      # 一般ユーザーでログインする
      sign_in(@general_user)
      # 見積承認待ち一覧へ遷移する
      visit approvals_path
      # 一覧の中に@quotationのリンクがあることを確認する
      expect(page).to have_link @quotation.title, href: edit_approval_path(@quotation)
      # 承認編集ページに遷移しようとするとメニュー画面に遷移する
      visit edit_approval_path(@quotation)
      expect(current_path).to eq(root_path)
      # 「画面を閲覧する権限がありません。」の文字が存在することを確認する
      expect(page).to have_content('画面を閲覧する権限がありません。')
    end

  end
  
end


Spec.describe '見積差し戻し', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @quotation = FactoryBot.create(:quotation)
    # 見積を差し戻し状態にする
    @quotation.update(approval: 2 )
  end

  context '差し戻し見積を再申請できるとき' do 

    it 'ユーザーは差し戻された見積を編集し再申請できる' do
      # ログインする
      sign_in(@user)
      # 見積印刷待ち一覧に遷移する
      visit index2_approvals_path
      # @quotationへのリンクが存在することを確認する
      expect(page).to have_link @quotation.title, href: edit_quotation_path(@quotation)
      # 見積編集ページに遷移する
      visit edit_quotation_path(@quotation)
      # 見積情報が入力されていることを確認する
      expect(
        find('#quotation_title').value
      ).to eq(@quotation.title)
      expect(
        find('#quotation_charge').value
      ).to eq(@quotation.charge)
      expect(
        find('#quotation_delivery_date').value
      ).to eq(@quotation.delivery_date)
      expect(
        find('#quotation_expiration_date').value
      ).to eq(@quotation.expiration_date)
      expect(
        find('#quotation_delivery_place').value
      ).to eq(@quotation.delivery_place)
      expect(
        find('#quotation_business_terms').value
      ).to eq(@quotation.business_terms)
      # 情報を編集する
      fill_in 'quotation_title', with: "#{@quotation.title}+編集"
      fill_in 'quotation_charge', with: "#{@quotation.charge}+編集"
      fill_in 'quotation_delivery_date', with: "#{@quotation.delivery_date}+編集"
      fill_in 'quotation_expiration_date', with: "#{@quotation.expiration_date}+編集"
      fill_in 'quotation_delivery_place', with: "#{@quotation.delivery_place}+編集"
      fill_in 'quotation_business_terms', with: "#{@quotation.business_terms}+編集"
      # 編集してもQuotationのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Quotation.count }.by(0)
      # 見積顧客一覧のページに遷移することを確認する
      expect(current_path).to eq(quotations_path)
      # 「見積を作成しました(承認待ち)」の文字が存在することを確認する
      expect(page).to have_content('見積を作成しました(承認待ち)')
      # 見積承認待ち一覧へ遷移する
      visit approvals_path
      # 編集した内容が一覧に反映されていることを確認する
      expect(page).to have_content("#{@quotation.title}+編集")
    end

  end

end