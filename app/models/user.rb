class User < ApplicationRecord
  rolify

  has_many :quotations

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  with_options presence: true do
    validates :employee_number,      uniqueness: { case_sensitive: true }, format: { with: /\A[0-9]{4}\z/ } #数字4桁のみ
    validates :password,             confirmation: true, format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,16}\z/i } #英字、数字を含む8~16文字
    validates :password_confirmation
    validates :name
    validates :admin_id,             numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 2 }
  end

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
