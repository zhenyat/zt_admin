#!/usr/bin/env ruby
#################################################################################
#   view_nested_form.rb
#
#   Generates View file for polymorphic model: 
#     admin/views/<model_name_plural>/_nested_from.html.erb
#
#   04.04.2022  ZT
################################################################################
module ZtAdmin
  action_report "#{$relative_views_path}/_nested_form.html.erb"

  file = File.open("#{$absolute_views_path}/_nested_form.html.erb", 'w')

  file.puts "<br>"
  file.puts "<div class=\"bg-secondary p-2 text-dark bg-opacity-10\">"
  file.puts "#{TAB}<% entity = object.class.name.constantize %>"
  file.puts "#{TAB}<% if entity._reflections['#{$name.pluralize}'].present? %>"
  file.puts "#{TAB*2}<h3>#{$model.pluralize}</h3>"
  file.puts "#{TAB*2}<%= f.simple_fields_for :#{$name.pluralize}, new_record: false do |form| %>"
  file.puts "#{TAB*3}<div class=\"forum-group\">"
  $attr_names.each do |attr_name|
    if attr_name == "#{$name}able"
      file.puts "#{TAB*4}<%= form.hidden_field :#{$name}able_type, value: entity %>"
      file.puts "#{TAB*4}<%= form.hidden_field :#{$name}able_id,   value: object.id %>"
    elsif attr_name == 'status'
      file.puts "#{TAB*4}<%= form.input :status, default: 0 %>"
    elsif attr_name == 'country_code'   # Phone model attribute
      file.puts "#{TAB*4}<%= phone_form.input :country_code, priority: ['RU', 'KZ', 'UA'] %>"
    else
      file.puts "#{TAB*4}<%= form.input :#{attr_name} %>"
    end
  end
  file.puts "#{TAB*3}</div>"
  file.puts "#{TAB*2}<% end %>"
  file.puts "#{TAB}<% end %>"
  file.puts "</div>"
end
