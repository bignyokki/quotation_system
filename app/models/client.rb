class Client < ApplicationRecord
    has_many :quotations

    validates :name,         presence: true
    validates :name_kana,    presence: true
end
