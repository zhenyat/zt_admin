#!/usr/bin/env ruby
#################################################################################
#   view_show.rb
#
#   Generates View file: admin/views/<model_name_plural>/show.html.erb
#
#   20.03.2022  ZT
#   28.05.2022  Last update (avatar)
################################################################################
module ZtAdmin
  action_report "#{$relative_views_path}/show.html.erb"

  file = File.open("#{$absolute_views_path}/show.html.erb", 'w')

  file.puts "<div class='container'>"
  file.puts "#{TAB}<p style='color: green'><%= notice %></p>"
  if $avatar
    file.puts "#{TAB}<h1>"
    file.puts "#{TAB*2}<%= t #{$model}.model_name.human %>"
    file.puts "#{TAB*2}<%= render 'admin/shared/show_avatar', object: @#{$name}, size: 50 %>"
    file.puts "#{TAB}</h1>"
  else
    file.puts "#{TAB}<h1><%= t #{$model}.model_name.human %></h1>" 
  end
  file.puts "#{TAB}<%= render @#{$name} %>"
  file.puts "#{TAB}<%= render 'admin/shared/show_actions', object: @#{$name} %>"
  file.puts "</div>"
  file.close
end
