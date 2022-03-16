#########################################################################
# UUID primary key is applied for Model generation
#
# Don't forget migration:   `r g migration enable_UUID`
#
# https://itnext.io/using-uuids-to-your-rails-6-application-6438f4eeafdf
######################################################################### 
Rails.application.config.generators do |g|
  g.orm :active_record, primary_key_type: :uuid
end