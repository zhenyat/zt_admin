###########################################################
#   Sets 'position' attribute auto-incrementally
###########################################################
module Positionable
  extend ActiveSupport::Concern

  included do
    before_save :set_position
  end
  
  def set_position
    if self.id.blank?
      last_position = self.class.name.constantize.order(:position).last
      self.position = last_position.blank? ? 1 : last_position.position.to_i + 1
    end
  end
end