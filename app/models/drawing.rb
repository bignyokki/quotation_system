class Drawing < ApplicationRecord
  belongs_to :quotation

  with_options presence: true do
    validates :figure_number
    validates :surface_treatment
    validates :quantity,         numericality: true
    validates :price,            numericality: true
  end
end
