class Admin < ActiveHash::Base
  self.data = [
    { id: 1, name: '管理者ユーザー' },
    { id: 2, name: '一般ユーザー' }
  ]

  include ActiveHash::Associations
  has_many :users

end