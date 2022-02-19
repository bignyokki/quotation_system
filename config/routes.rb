Rails.application.routes.draw do
  devise_for :users
  root to: "menus#index"
  get 'menus/index'
end
