################################################################################
#   Handles ActiveStorage avatars
################################################################################
module Avatarable
  extend ActiveSupport::Concern

  included do
    has_one_attached  :avatar, dependent: :destroy
    attribute         :avatar_url, :string, default: ''
    before_destroy    :destroy_avatar, prepend: true

    attr_accessor     :remove_avatar
  end

  # Removes avatar (if any) for destroyed instance 
  def destroy_avatar
    self.avatar.purge if self.avatar.attached?
  end
end
