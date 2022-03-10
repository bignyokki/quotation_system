class Quotation < ApplicationRecord
  belongs_to :user
  belongs_to :client

  validates :title, presence: true
  validates :total_price, presence: true
end
