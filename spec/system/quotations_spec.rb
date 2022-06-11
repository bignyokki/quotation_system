require 'rails_helper'

RSpec.describe '見積新規登録', type: :system do
  before do
    @client = FactoryBot.create(:client)
    @price_scale = FactoryBot.create(:price_scale)
    @user = FactoryBot.create(:user)
    @quotation = FactoryBot.build(:quotation)
    @drawing = FactoryBot.build(:drawing)
  end

  context '見積新規登録ができるとき' do 

    it '正しい情報を入力すれば見積新規登録ができる' do
      # ログインする
      sign_in(@user)
      # 見積新規作成ページに遷移する
      visit new_quotation_path
      # 見積情報を入力する
      fill_in 'タイトル', with: @quotation.title
      select @client.name, from: 'quotation_client_id'
      fill_in 'ご担当', with: @quotation.charge
      fill_in '納期', with: @quotation.delivery_date
      fill_in '有効期限', with: @quotation.expiration_date
      fill_in '受渡場所', with: @quotation.delivery_place
      fill_in '取引条件', with: @quotation.business_terms
      # 図面を追加ボタンを押すとQuotationのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Quotation.count }.by(1)
      # 図面登録画面に遷移することを確認する
      expect(page).to have_content('図面登録')
      # 図面情報を入力する
      fill_in 'drawing[figure_number]', with: @drawing.figure_number
      fill_in 'drawing[product_name]', with: @drawing.product_name
      fill_in 'drawing[material]', with: @drawing.material
      select @price_scale.title, from: 'drawing_surface_treatment'
      # 寸法を入力すると自動計算され入力されることを確認する
      fill_in 'length', with: 100
      fill_in 'width', with: 100
      fill_in 'height', with: 10
      expect( find('#weight_result').value ).to_not be_nil
      expect( find('#weight_scale').value ).to_not be_nil
      expect( find('#weight_price').value ).to_not be_nil
      expect( find('#area_result').value ).to_not be_nil
      expect( find('#area_scale').value ).to_not be_nil
      expect( find('#area_price').value ).to_not be_nil
      expect( find('#size_result').value ).to_not be_nil
      expect( find('#size_scale').value ).to_not be_nil
      expect( find('#size_price').value ).to_not be_nil
      # 決定ボタンを押すと、ボタンに対応した数値がprice_result欄に入力されることを確認する
      find('#weight_price_select').click
      expect( find('#price_result').value ).to eq( find('#weight_price').value )
      # 図面情報を入力する
      fill_in '数量', with: @drawing.quantity
      # 次の図面を登録ボタンを押すと登録した図面の情報が表示され、Drawingのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
        expect(page).to have_content(@drawing.figure_number)
      }.to change { Drawing.count }.by(1)
      # 「図面の登録を終了」のリンクを押して見積編集画面に遷移することを確認する
      click_link '図面の登録を終了'
      expect(page).to have_content('新規見積入力(2/2)')
      # 見積を保存ボタンを押すとQuotationのカウントが変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Quotation.count }.by(0)
      # 見積一覧ページに遷移することを確認する
      expect(current_path).to eq(quotations_path)
      # 「見積を作成しました(承認待ち)」の文章が存在するのを確認する
      expect(page).to have_content('見積を作成しました(承認待ち)')
      # 見積承認ページに遷移する
      visit approvals_path
      # 登録した見積が一覧に存在することを確認する
      expect(page).to have_content(@quotation.title)
    end
  end

  context '見積新規登録が出来ないとき' do 

    it '正しい情報を入力しないと見積が登録できない' do
      # ログインする
      sign_in(@user)
      # 見積新規作成ページに遷移する
      visit new_quotation_path
      # 見積情報を入力する
      fill_in 'タイトル', with: ''
      fill_in 'ご担当', with: ''
      fill_in '納期', with: ''
      fill_in '有効期限', with: ''
      fill_in '受渡場所', with: ''
      fill_in '取引条件', with: ''
      # 図面を追加ボタンを押してもQuotationのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Quotation.count }.by(0)
      # 「Client must exist」と表示されることを確認する
      expect(page).to have_content('Client must exist')
    end

  end

end

      
