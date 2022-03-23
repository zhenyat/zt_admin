#!/usr/bin/env ruby
#################################################################################
#   view_index.rb
#
#   Generates View file: admin/views/<model_name_plural>/index.html.erb
#
#   20.03.2022  ZT
################################################################################
module ZtAdmin
  relative_path = "#{$relative_views_path}/index.html.erb"
  action_report relative_path

  file = File.open("#{$absolute_views_path}/index.html.erb", 'w')

  #file.puts "\n%h1= t('actions.listing', model: @#{$name_plural}.first.class.model_name.human)\n"    # Page Title
  file.puts "<h1><%= t #{$model}.model_name.human(count: 2) %></h1>"  # Page Title
  
  # Table heads line
  file.puts "<table class='table table-hover'>\n#{TAB}<thead>"

  $attr_names.each do |attr_name|
  #  file.puts "#{TAB*3}%th= " << '"#{@' << "#{$name_plural}.first.class.human_attribute_name(:#{attr_name})" << '}"' unless attr_name.include?('password') || attr_name.include?('remember') || attr_name.include?('status')
    file.puts "#{TAB*3}<th>" << "<%= #{$model}.human_attribute_name(:#{attr_name}) %></th>" unless attr_name.include?('password') || attr_name.include?('remember') || attr_name.include?('status')
  end
  file.puts "#{TAB*3}<th><%= t 'status.status' %></th>"
  file.puts "#{TAB*3}<th><%= t 'actions.actions' %><th>"
  file.puts "#{TAB}</thead>"

  # Table body
  file.puts "\n#{TAB}<tbody>"
  file.puts "#{TAB*2}<% @#{$name_plural}.each do |#{$name}| %>"
  file.puts "#{TAB*3}<tr>"
  $attr_names.each_with_index do |attr_name, index|
    if $attr_types[index] == 'references'
      file.puts "#{TAB*4}<td><%= #{$name}.#{attr_name}.title %></td>"
    else
      if attr_name == 'status'
        file.puts "#{TAB*4}<td><%= status_mark #{$name}.#{attr_name} %></td>"
      else
        file.puts "#{TAB*4}<td><%= #{$name}.#{attr_name} %></td>" unless attr_name.include?('password') || attr_name.include?('remember')
      end
    end
  end
  file.puts "#{TAB*4}<% if #{$name}.cover_image.attached? %>"
  file.puts "#{TAB*5}<td><%= image_tag #{$name}.cover_image.variant(resize_to_fit: [50, 50]) %></td>"
  file.puts "#{TAB*4}<% else %>"
  file.puts "#{TAB*5}<td></td>"
  file.puts "#{TAB*4}<% end %>"
  
  file.puts "#{TAB*4}<td><%= render 'admin/shared/index_buttons', resource: #{$name} %></td>"
  file.puts "#{TAB*3}</tr>"
  file.puts "#{TAB*2}<% end %>"
  file.puts "#{TAB}</tbody>"
  file.puts "</table>"

  # Action buttons
  file.puts "<br>\n<div class='row'>\n#{TAB}<div class='col-md-2'>"
  file.puts "#{TAB*2}<%= link_to t('actions.create'), new_admin_#{$name}_path, class: 'btn btn-primary btn-sm' %>"
  file.puts "#{TAB}</div>\n</div>"
  file.close
end