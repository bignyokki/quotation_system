class User < ApplicationRecord
  rolify

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  validates :employee_number, presence: true, uniqueness: true

  def email_required?
    false
  end

  def email_changed?
    false
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :admin

end
