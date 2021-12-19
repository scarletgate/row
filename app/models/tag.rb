class Tag < ApplicationRecord
  has_many :tag_maps, dependent: :destroy
  has_many :post, through: :tag_maps
end
