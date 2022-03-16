################################################################################
#   If gem 'ancestry' is applied
#
#   Examples:
#     women = Category.create(name: 'Women')
#     women_bags = Category.create(name: 'Bags', parent: women)
#     women_clothes = Category.create(name: 'Clothes', parent: women)
#   26.12.2020  ZT
#   14.02.2021  visible scope
################################################################################
module Heritable
  extend ActiveSupport::Concern

  included do
    has_ancestry

    before_validation do
      self.ancestry = nil if self.ancestry.blank?
    end

    # to be seen in Admin Tree
    def visible_in_tree()
      return(false) if !self.visibility
      if self.ancestors?
        self.ancestors.each do |ancestor|
          return(false) if !ancestor.visibility
        end
      else  # just a root 
        return true
      end
      return true
    end

    # To be seen in FE 
    def self.visible
      visibles = []
      self.active.each do |object|
        next if !object.visibility?
        if object.ancestors?
          show = true
          object.ancestors.each do |ancestor|
            if !ancestor.visibility?
              show = false
              break
            end
          end
          visibles << object if show
        else  # root
          visibles << object
        end
      end
      self.where(id: visibles.map(&:id))
    end
  end
end