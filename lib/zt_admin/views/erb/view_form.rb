#!/usr/bin/env ruby
################################################################################
#   view_form.rb
#
#   Generates partial file: admin/views/<models>/_form.html.erb
#
#   23.02.2015  ZT (bkc_admin)
#   09.07.2016  Updated for zt_admin
#   21.07.2016  no blank option for DDL
#   02.08.2016  Final update for bootstrap
#   03.08.2016  Bug fixed
#   19.12.2020  RichText & ActiveStorage Images fields are added
#   25.12.2020  Ancestry
#   22.03.2022  Rails 7
#   29.05.2022  Avatar
################################################################################
module ZtAdmin
  relative_path = "#{$relative_views_path}/_form.html.erb"
  action_report relative_path

  file = File.open("#{$absolute_views_path}/_form.html.erb", 'w')
  file.puts "<div class=\"container\">"
  file.puts "#{TAB}<div class=\"row\">"
  file.puts "#{TAB*2}<div class=\"col-ms-6\">"  # DO NOT UNDERSTAND why '-ms-' working!

  file.puts "#{TAB*3}<%=  simple_form_for([:admin, @#{$name}], html: {multipart: true}) do |f| %>"

  # Errors block
  file.puts "#{TAB*4}<%= f.error_notification %>"
  file.puts "#{TAB*4}<%= f.error_notification message: f.object.errors[:base].to_sentence if f.object.errors[:base].present? %>"

  # Input fields
  file.puts "\n#{TAB*4}<div class=\"form-inputs\">"
  file.puts "#{TAB*5}<%= render 'admin/shared/form_ancestry', f: f, object: @#{$name} %>" if $ancestry

  $attr_names.each_with_index do |attr_name|
    if attr_name.match 'password'
      file.puts "#{TAB*5}<%= f.input :password %>"
      file.puts "#{TAB*5}<%= f.input :password_confirmation %>"
    elsif attr_name.match 'remember_digest'
      # skip the attribute
    elsif attr_name.match 'position'
      file.puts "#{TAB*5}<%= f.input :#{attr_name}, as: :hidden %>"
    elsif attr_name.match 'status'
      file.puts "#{TAB*5}<%= f.input :status, default: 0 %>"
      file.puts "#{TAB*5}<%#= render 'admin/shared/status_buttons', f: f %>"
    else
      if $enum.include?(attr_name)
        file.puts "#{TAB*5}<%= f.input :#{attr_name}, include_blank: false %>"
      else
        file.puts "#{TAB*5}<%= f.input :#{attr_name} %>"
      end
    end
  end

  # Rich Text & Images Input fields
  file.puts "\n#{TAB*5}<%= render 'admin/shared/form_rich_text_content', f: f, object: @#{$name} %>" if $content
  file.puts "#{TAB*5}<%= render 'admin/shared/form_images', f: f, object: @#{$name} %>"   if $images 
  file.puts "#{TAB*5}<%= render 'admin/shared/form_avatar', f: f, object: @#{$name} %>"   if $avatar 

  if $modelables.present?
    $modelables.each do |modelable|
      file.puts "#{TAB*5}<%= render 'admin/#{modelable.pluralize}/nested_form', f: f, object: @#{$name} %>"
    end
  end
  file.puts "\n#{TAB*5}<%= render 'admin/shared/form_actions', f: f, object: @#{$name} %>"

  file.puts "#{TAB*4}</div>"
  file.puts "#{TAB*3}<% end %>"
  file.puts "#{TAB*2}</div>"
  file.puts "#{TAB}</div>"
  file.puts "</div>"

  file.close
end