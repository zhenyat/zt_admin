#!/usr/bin/env ruby
#################################################################################
#   view_show.rb
#
#   Generates View file: admin/views/<model>/show.html.haml
#
#   05.03.2015  ZT (for bkc_admin)
#   06.07.2016  Copied for zt_admin
#   02.08.2016  Updated with bootstrap
#   03.08.2016  Bugs fixed
#   19.12.2020  RichText & ActiveStorage Images fields are added
#   25.12.2020  Ancestry
################################################################################
module ZtAdmin
  relative_path = "#{$relative_views_path}/show.html.haml"
  action_report relative_path

  file = File.open("#{$absolute_views_path}/show.html.haml", 'w')

  file.puts ".container"
  #file.puts "%p#notice= notice\n\n"
  file.puts "#{TAB}%h1= t #{$model}.model_name.human"

  file.puts "#{TAB}%table.table.table-striped\n#{TAB*2}%tbody"
  file.puts "#{TAB*3}- @#{$name}.attributes.each do |key, value|"

  file.puts "#{TAB*4}- unless key == 'id' || key.include?('digest') || key == 'created_at' || key == 'updated_at'"
  file.puts "#{TAB*5}%tr"
  
  file.puts "#{TAB*6}- if key == 'status'"
  file.puts "#{TAB*7}%td= t 'status.status'"
  file.puts "#{TAB*7}%td= status_mark @#{$name}.status"

  file.puts "#{TAB*6}- elsif key == 'ancestry'"

  file.puts "#{TAB*7}- if @" << "#{$name}.parent.present?"
  file.puts "#{TAB*8}%td= t 'tree.parent'"
  file.puts "#{TAB*8}- if #{$model}.column_names.include? 'title'"
  file.puts "#{TAB*9}%td= " << '"#' << "{@" <<  "#{$name}" << ".parent.title} (id: #" << "{@" << "#{$name}" << '.ancestry})"'
  file.puts "#{TAB*8}- elsif #{$model}.column_names.include? 'name'"
  file.puts "#{TAB*9}%td= " << '"#' << "{@" <<  "#{$name}" << ".parent.name} (id: #" << "{@" << "#{$name}" << '.ancestry})"'
  file.puts "#{TAB*8}- else"
  file.puts "#{TAB*9}%td= " << '"#' << "{@" << "#{$name}" << '.ancestry})"'

  file.puts "#{TAB*7}- if @#{$name}.children.present?"
  file.puts "#{TAB*8}%tr"
  file.puts "#{TAB*9}%td= t 'tree.children'"
  file.puts "#{TAB*9}%td"
  file.puts "#{TAB*10}- @#{$name}.children.each do |child|"
  file.puts "#{TAB*11}- if #{$model}.column_names.include? 'title'"
  file.puts "#{TAB*12}= " << '"#{child.title} (id=#{child.id})"'
  file.puts "#{TAB*11}- elsif #{$model}.column_names.include? 'name'"
  file.puts "#{TAB*12}= " << '"#{child.name} (id=#{child.id})"'
  file.puts "#{TAB*11}- else"
  file.puts "#{TAB*12}= " << '"#{child.id}"'
  file.puts "#{TAB*11}- unless child == @#{$name}.children.last"
  file.puts "#{TAB*12}%br"

  file.puts "#{TAB*6}- else"
  file.puts "#{TAB*7}%td= t " << '"activerecord.attributes.' << "#{$name}." << '#{key}"'
  file.puts "#{TAB*7}%td= value"

  # Images & Rich Text
  file.puts "#{TAB*3}= render 'admin/shared/show_images', object: @#{$name}"
  file.puts "#{TAB}= render 'admin/shared/show_rich_text_content', object: @#{$name}"
  file.puts "#{TAB}= render 'admin/shared/show_actions', object: @#{$name}"

  file.close
end