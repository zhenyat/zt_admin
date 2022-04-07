#!/usr/bin/env ruby
#################################################################################
#   view_nested_show.rb
#
#   Generates View file for polymorphic model: 
#     admin/views/<model_name_plural>/_nested_show.html.erb
#
#   07.04.2022  ZT
################################################################################
module ZtAdmin
  action_report "#{$relative_views_path}/_nested_show.html.erb"

  file = File.open("#{$absolute_views_path}/_nested_show.html.erb", 'w')

  file.puts "<br>"
  file.puts "<div class=\"bg-info p-2 text-dark bg-opacity-10\">"
  file.puts "#{TAB}<h4>#{$name.capitalize}</h4>"
  file.puts "#{TAB}<table class='table table-striped'>"
  file.puts "#{TAB*2}<tbody>"
  file.puts "#{TAB*3}<% #{$name}.attributes.each do |key, value| %>"
  file.puts "#{TAB*4}<% unless key == 'id' || key == 'created_at' || key == 'updated_at' %>"
  file.puts "#{TAB*5}<tr>"
  file.puts "#{TAB*6}<% if key == 'status' %>"
  file.puts "#{TAB*7}<td><%= t 'status.status' %></td>"
  file.puts "#{TAB*7}<td><%= status_mark #{$name}.status %></td>"
  file.puts "#{TAB*6}<% else %>"
  file.puts "#{TAB*7}<td><%= t \"activerecord.attributes.#{$name}" + '.#{key}" %></td>'
  file.puts "#{TAB*7}<td><%= value %></td>"
  file.puts "#{TAB*6}<% end %>"
  file.puts "#{TAB*5}</tr>"
  file.puts "#{TAB*4}<% end %>"
  file.puts "#{TAB*3}<% end %>"
  file.puts "#{TAB*2}</tbody>"
  file.puts "#{TAB}</table>"
  file.puts "</div>"
end
