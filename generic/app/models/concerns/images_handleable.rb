################################################################################
#   Handles ActiveStorage images
################################################################################
module ImagesHandleable
  extend ActiveSupport::Concern

  included do
    has_one_attached  :cover_image
    attribute         :cover_image_url, :string, default: ''
    has_many_attached :images
    before_destroy    :remove_all_images, prepend: true

    attr_accessor     :remove_cover_image
  end

  # Removes all images (if any) for destroyed instance 
  def remove_all_images
    self.cover_image.purge                 if self.cover_image.attached?
    self.images.each {|image| image.purge} if self.images.attached?
  end
end
