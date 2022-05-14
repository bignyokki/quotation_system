Rails.application.routes.draw do

  root to: "menus#index"

  # メニュー画面
  get 'menus/index'

  resources :clients do
    member do
      # 顧客別見積一覧ページ
      get :index_quotations
    end
  end
  resources :price_scales
  resources :quotations do
    resources :drawings
  end
  resources :approvals, only: [:index, :edit, :update] do
    collection do
      # 差し戻し一覧ページ
      get :index2
    end
  end
  resources :printings, only: [:index, :show]

  get 'users/index'
  
  devise_for :users, :controllers => {
    # オーバーライドした'users/registrations_controller'をルーティングする
    :registrations => 'users/registrations'
  }
  # devise_scopeで新しくルーティングを追加する
  devise_scope :user do
    get 'users/:id/edit' => 'users/registrations#edit', as: :edit_other_user_registration
    match 'users/:id', to: 'users/registrations#update', via: [:patch, :put], as: :other_user_registration
    delete 'users/:id', to: 'users/registrations#destroy', as: :destroy_other_user_registration
  end

end
