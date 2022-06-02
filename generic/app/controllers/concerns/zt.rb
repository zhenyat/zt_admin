module Zt
  ##############################################################################
  #   18.11.2016  ZT
  #   09.01.2017  Updated (following the RoR guide) *set_locale*
  #               *default_url_options* added
  #   15.11.2020  No classic autoloader: Zeitwerk only! 
  #   11.02.2022  locale_from_header
  ##############################################################################

  ##############################################################################
  # Adds multiple url options (*locale* here).
  #
  # An alternative solution: *polymorphic* urls (e.g. redirect_to polymorphic_url)
  ##############################################################################
  def default_url_options
    { locale: I18n.locale }
  end

  ##############################################################################
  #   Gets locale from page header
  #   https://www.youtube.com/watch?v=lCyP8uKRqQo&t=231s
  ##############################################################################
  def locale_from_header
    request.env.fetch('HTTP_ACCEPT_LANGUAGE', '').scan(/[a-z]{2}/).first
  end
  
  ##############################################################################
  #   Sets locale  before_action
  #   Called by:   application_controller.rb & sessions_controller.rb
  ##############################################################################
  def set_locale
    I18n.locale = params[:locale] || locale_from_header || I18n.default_locale
  end
end
