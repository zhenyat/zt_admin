#!/usr/bin/env ruby
#################################################################################
#   view_new.rb
#
#   Generates View file: admin/views/<model>/new.html.haml
#
#   23.02.2015  ZT (for bkc_admin)
#   06.07.2016  Copied for zt_admin
#   02.08.2016  Updated for bootstrap
#   03.08.2016  Bug fixed
#   03.04.2022  Bug fixed
################################################################################
module ZtAdmin
  relative_path = "#{$relative_views_path}/new.html.erb"
  action_report relative_path

  file = File.open("#{$absolute_views_path}/new.html.erb", 'w')

  file.puts '<h1><%= "#{' << "t('actions.new', model: @#{$name}.class.model_name.human)" << '}" %></h1>'
  file.puts "<%= render 'form' %>"
  file.close
end