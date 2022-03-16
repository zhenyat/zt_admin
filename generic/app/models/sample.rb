###########################################################
# Model:  Sample
#
# Purpose:  Demo Entity
#
# Attributes
#   name      - string
#   title     - string
#   price     - decimal, default: 0.0
#   quantity  - integer, default: 0
#   position  - sorting index:  integer, not NULL

#   status    - enum { active (0) | archived (1) }
#
#   content     - Active Text attachement
#   cover_image - Active Storage attachement
#   images      - Active Storage attachements
#
#   05.11.2020  ZT
#   12.11.2020  Images handling shifted to Concerns
#   15.11.2020  Corrected
#   20.12.2020  Position added
###########################################################
class Sample < ApplicationRecord
  include Positionable
  include ImagesHandleable
  has_rich_text :content
  enum status:  %w(active archived)
  
  validates :name,     presence: true, uniqueness: true
  validates :title,    presence: true
  validates :price,    presence: true, numericality: {greater_than_or_equal_to: 0}
  validates :quantity, presence: true, numericality: {greater_than_or_equal_to: 0}
end
