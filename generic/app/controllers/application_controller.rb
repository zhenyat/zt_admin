class ApplicationController < ActionController::Base
  include Zt
  # protect_from_forgery with: :exception   # for API?
  before_action :set_locale
end
