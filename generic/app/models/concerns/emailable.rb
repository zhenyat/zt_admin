################################################################################
#   Handles and validates email attribute to be saved
################################################################################
module Emailable
  extend ActiveSupport::Concern

  included do
    before_save {self.email.downcase!}

    valid_email_regex = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, presence: true, format: {with: valid_email_regex}, uniqueness: {case_sensitive: false}
  end
end