class Client < ApplicationRecord
    validates :name,         presence: true
    validates :name_kana,    presence: true
end
