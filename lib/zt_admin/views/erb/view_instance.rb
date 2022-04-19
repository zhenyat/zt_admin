#!/usr/bin/env ruby
#################################################################################
#   view_instance.rb
#
#   Generates View file: admin/views/<model_name_plural>/_<model_name>.html.erb
#
#   20.03.2022  ZT
################################################################################
module ZtAdmin
  action_report "#{$relative_views_path}/_#{$name}.html.erb"

  file = File.open("#{$absolute_views_path}/_#{$name}.html.erb", 'w')

  file.puts "<div class='container'>"
  file.puts "#{TAB}<table class='table table-striped'>\n#{TAB*2}<tbody>"
  file.puts "#{TAB*3}<% @#{$name}.attributes.each do |key, value| %>"
  file.puts "#{TAB*4}<tr>"
  file.puts "#{TAB*5}<% unless key == 'id' || key.include?('digest') || key == 'created_at' || key == 'updated_at' %>"
  file.puts "#{TAB*6}<% if key == 'status' %>"
  file.puts "#{TAB*7}<td><%= t 'status.status' %></td>"
  file.puts "#{TAB*7}<td><%= status_mark @#{$name}.status %></td>"
  file.puts "#{TAB*6}<% else %>"
  file.puts "#{TAB*7}<td><%= t \"activerecord.attributes.#{$name}" + '.#{key}" %></td>'
  file.puts "#{TAB*7}<td><%= value %></td>"
  file.puts "#{TAB*6}<% end %>"
  file.puts "#{TAB*5}<% end %>"
  file.puts "#{TAB*4}</tr>"
  file.puts "#{TAB*3}<% end %>"
  file.puts "#{TAB*2}</tbody>"
  file.puts "#{TAB}</table>"

  file.puts "#{TAB}<%= render 'admin/shared/show_rich_text_content', object: @#{$name} %>"
  file.puts "#{TAB}<%= render 'admin/shared/show_images', object: @#{$name} %>"
  if $modelables.present?
    $modelables.each do |modelable|
      file.puts "#{TAB}<%= render('admin/#{modelable.pluralize}/nested_show', #{modelable}: @#{$name}.#{modelable.pluralize}.first) if @#{$name}.#{modelable.pluralize}.present? %>"
    end
  end
  file.puts "</div>"
end
