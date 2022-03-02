Rails.application.routes.draw do
  resources :clients, only: [:index, :new, :create]
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

  root to: "menus#index"
  get 'menus/index'
end
