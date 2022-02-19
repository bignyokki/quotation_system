class Ah_admin < ActiveHash::Base
  self.data = [
    { id: 1, name: '一般ユーザー' },
    { id: 2, name: '管理者ユーザー' }
  ]

  include ActiveHash::Associations
  has_many :users

end