class Quotation < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :client
  has_many :drawings, dependent: :destroy

  accepts_nested_attributes_for :drawings, allow_destroy: true, reject_if: :all_blank

  validates :title, presence: true
end
