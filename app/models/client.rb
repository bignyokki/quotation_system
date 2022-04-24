class Client < ApplicationRecord
    has_many :quotations

    validates :name,         presence: true
    validates :name_kana,    presence: true

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
