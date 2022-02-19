Rails.application.routes.draw do
  root to: "menus#index"
  get 'menus/index'
end
