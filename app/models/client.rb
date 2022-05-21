class Client < ApplicationRecord
    has_many :quotations


    VALID_PHONE_NUMBER_REGEX = /\A0(\d{1}-\d{4}|\d{2}-\d{3}|\d{3}-\d{2}|\d{4}-\d{1}|\d{2}-\d{4})-\d{4}\z/
    VALID_FAX_NUMBER_REGEX = /\A0(\d{1}-\d{4}|\d{2}-\d{3}|\d{3}-\d{2}|\d{4}-\d{1}|)-\d{4}\z/

    validates :name,         presence: true
    validates :name_kana,    presence: true
    validates :phone_number, format: { with: VALID_PHONE_NUMBER_REGEX }, allow_blank: true
    validates :fax_number,   format: { with: VALID_FAX_NUMBER_REGEX }, allow_blank: true
    validates :email,        format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }, allow_blank: true
    validates :postal_code,  format: { with: /\A\d{3}-\d{4}\z/ }, allow_blank: true

    # clientをかなの行ごとに分類するメソッド
    def self.classification
        name_kana_set1 = "name_kana LIKE ? OR name_kana LIKE ? OR name_kana LIKE ? OR name_kana LIKE ? OR name_kana LIKE ?"
        name_kana_set2 = "name_kana LIKE ? OR name_kana LIKE ? OR name_kana LIKE ?"
        clients = [
          Client.where("#{name_kana_set1}","あ%", "い%", "う%", "え%", "お%"),
          Client.where("#{name_kana_set1}","か%", "き%", "く%", "け%", "こ%"),
          Client.where("#{name_kana_set1}","さ%", "し%", "す%", "せ%", "そ%"),
          Client.where("#{name_kana_set1}","た%", "ち%", "つ%", "て%", "と%"),
          Client.where("#{name_kana_set1}","な%", "に%", "ぬ%", "ね%", "の%"),
          Client.where("#{name_kana_set1}","は%", "ひ%", "ふ%", "へ%", "ほ%"),
          Client.where("#{name_kana_set1}","ま%", "み%", "む%", "め%", "も%"),
          Client.where("#{name_kana_set2}","や%", "ゆ%", "よ%"),
          Client.where("#{name_kana_set1}","ら%", "り%", "る%", "れ%", "ろ%"),
          Client.where("#{name_kana_set2}","わ%", "を%", "ん%")
        ]
        return clients
      end

end
