class Drawing < ApplicationRecord
  belongs_to :quotation
  belongs_to :price_scale
end
