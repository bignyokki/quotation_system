class User < ApplicationRecord
  rolify

  has_many :quotations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  validates :employee_number, presence: true, uniqueness: true, format: { with: /\A[0-9]{4}\z/ } #数字4桁のみ
  validates :password, presence: true, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+{8,16}\z/i } #英字、数字を含む8~16文字
  validates :name, presence: true
  validates :admin_id, presence: true

  def email_required?
    false
  end

  def email_changed?
    false
  end

  # 他のユーザーのパスワードを変更できるようにする。（呼び出しがわで管理者権限をチェックする）
  def update_without_password(params, *options)
    current_password = params.delete(:current_password)

    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = if valid_password?(current_password)
       update_attributes(params, *options)
     else
       self.assign_attributes(params, *options)
       self.valid?
       self.errors.add(:current_password, current_password.blank? ? :blank : :invalid)
       false
     end

    update_attributes(params, *options)

    clean_up_passwords
    result  
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :admin

end
