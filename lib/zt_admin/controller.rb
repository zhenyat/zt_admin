#!/usr/bin/env ruby
################################################################################
#   Generates Admin Controller for the given Model
#
#   05.03.2015  ZT (bkc_admin version)
#   07.07.2016  modified to generate a standard rails controller code
#   10.09.2016  corrected: admin namespace & add password to permission list
#   09.11.2016  BaseController & basepolymorphic_url
#   21.01.2017  Flash & no polymorphic way
#   19.03.2022  zt_admin v.4 (Rails 7)
#   03.04.2022  polymorphic & modelable
#   28.05.2022  avatar
################################################################################
module ZtAdmin
  # admin directory
  relative_path = 'app/controllers/admin'
  admin_path    = "#{AppRoot}/#{relative_path}"

  action_report relative_path
  Dir.mkdir(admin_path) unless File.exist?(admin_path)

  # Controller file
  relative_path = "app/controllers/admin/#{$name_plural}_controller.rb"
  absolute_path = "#{AppRoot}/#{relative_path}"
  action_report relative_path

  file = File.open(absolute_path, 'w')

  # Generate controller code

  file.puts "class Admin::#{$model_plural}Controller < Admin::BaseController"
  file.puts "#{TAB}before_action :set_#{$name}, only: [:show, :edit, :update,:destroy]"
  file.puts "#{TAB}before_action :set_#{$polymorphic_name}s"    if $polymorphic
  file.puts "#{TAB}after_action  :remove_images, only: :update" if $images
  file.puts "#{TAB}after_action  :remove_avatar, only: :update" if $avatar

  file.puts "\n#{TAB}def index\n#{TAB*2}@#{$name_plural} = policy_scope(#{$model})\n#{TAB}end"
# file.puts "\n#{TAB}def index\n#{TAB*2}@#{$name_plural} = #{$model}.all\n#{TAB*2}authorize @#{$name_plural}\n#{TAB}end"

  file.puts "\n#{TAB}def show\n#{TAB*2}authorize @#{$name}\n#{TAB}end"

  file.puts "\n#{TAB}def new"
  file.puts "#{TAB*2}@#{$name} = #{$model}.new"
  if $modelables.present?
    $modelables.each do |modelable|
      file.puts "#{TAB*2}@#{$name}.#{modelable.pluralize}.build"
    end
  end
  file.puts "#{TAB*2}authorize @#{$name}\n#{TAB}end"

  file.puts "\n#{TAB}def edit\n#{TAB*2}authorize @#{$name}\n#{TAB}end"

  file.puts "\n#{TAB}def create\n#{TAB*2}@#{$name} = #{$model}.new(#{$name}_params)\n#{TAB*2}authorize @#{$name}"
  file.puts "#{TAB*2}if @#{$name}.save"
  file.puts "#{TAB*3}redirect_to admin_#{$name}_path(@#{$name}), notice: t('messages.created', model: @#{$name}.class.model_name.human)"
  file.puts "#{TAB*2}else#{TAB*3}\n#{TAB*3}render :new, status: :unprocessable_entity\n#{TAB*2}end\n#{TAB}end"
  #file.puts "\n#{TAB*2}if @#{$name}.save\n#{TAB*3}redirect_to polymorphic_url([:admin, @#{$name}], locale: params[:locale]), notice: t('messages.created', model: @#{$name}.class.model_name.human)\n#{TAB*2}else\n#{TAB*3}render :new\n#{TAB*2}end\n#{TAB}end"

  file.puts "\n#{TAB}def update\n#{TAB*2}authorize @#{$name}"
  file.puts "#{TAB*2}if @#{$name}.update(#{$name}_params)"
  file.puts "#{TAB*3}redirect_to admin_#{$name}_path(@#{$name}), notice: t('messages.updated', model: @#{$name}.class.model_name.human)"
  file.puts "#{TAB*2}else#{TAB*3}\n#{TAB*3}render :new, status: :unprocessable_entity\n#{TAB*2}end\n#{TAB}end"

  file.puts "\n#{TAB}def destroy\n#{TAB*2}authorize @#{$name}"
  file.puts "#{TAB*2}@#{$name}.destroy"
  file.puts "#{TAB*2}flash[:success] = t('messages.deleted', model: @#{$name}.class.model_name.human)"
  file.puts "#{TAB*2}redirect_to admin_#{$name_plural}_path\n#{TAB}end"

  file.puts "\n#{TAB}private"

  file.puts "\n#{TAB*2}# Uses callbacks to share common setup or constraints between actions"
  file.puts "#{TAB*2}def set_#{$name}\n#{TAB*3}@#{$name} = #{$model}.find(params[:id])\n#{TAB*2}end"

  if $avatar
    file.puts "\n#{TAB*2}# Removes avatar, if selected during Editing"
    file.puts "#{TAB*2}def remove_avatar"
    file.puts "#{TAB*3}@#{$name}.avatar.purge if #{$name}_params[:remove_avatar] == '1'"
    file.puts "#{TAB*2}end"
  end

  if $polymorphic
    file.puts "\n#{TAB*2}def set_#{$polymorphic_name}s"
    file.puts "#{TAB*3}@#{$polymorphic_name}s = Bank.active + Company.active + Partner.active"
    file.puts "#{TAB*3}@#{$polymorphic_name}_types_list = #{$model}.includes(:#{$polymorphic_name}).map(&:#{$polymorphic_name}_type).uniq.sort"

    file.puts "#{TAB*3}# @#{$polymorphic_name}s_collection = ("
    file.puts "#{TAB*3}#      Bank.all.map{|x| [x.name,    \"Bank:#\{x.id}\"]} +"
    file.puts "#{TAB*3}#   Partner.all.map{|x| [x.name, \"Partner:#\{x.id}\"]} +"
    file.puts "#{TAB*3}#   Company.all.map{|x| [x.name, \"Company:#\{x.id}\"]}"
    file.puts "#{TAB*3}# ).sort"

    file.puts "#{TAB*2}end"
  end

  if $images
    file.puts "\n#{TAB*2}# Removes images, selected during Editing"
    file.puts "#{TAB*2}def remove_images"
    file.puts "#{TAB*3}@#{$name}.cover_image.purge if #{$name}_params[:remove_cover_image] == '1'"
    file.puts "#{TAB*3}image_to_remove_ids = params['image_to_remove_ids']"
    file.puts "#{TAB*3}if image_to_remove_ids.present?"
    file.puts "#{TAB*4}image_to_remove_ids.each do |image_to_remove_id|"
    file.puts "#{TAB*5}@#{$name}.images.find(image_to_remove_id).purge"
    file.puts "#{TAB*4}end\n#{TAB*3}end\n#{TAB*2}end"
  end

  file.puts "\n#{TAB*2}# Only allows a trusted parameter 'white list' through"
  line = "#{TAB*2}def #{$name}_params\n#{TAB*3}params.require(:#{$name}).permit(\n#{TAB*4}"
  $attr_names.each do |attr_name|
    if $references_names.include? attr_name
      if $polymorphic
        line << ":#{$polymorphic_name}_id, :#{$polymorphic_name}_type, :#{$polymorphic_name}_gid"
      else
        line << ":#{attr_name}_id"                      # FK attribute
      end
    else
      line << ":#{attr_name}"                           # Ordinary attribute
    end
    # While non-last attribute and no polymorphic associations
    line << ", " unless attr_name == $attr_names.last && $modelables.empty?
  end

  if $model == "User"
    line << ",  :password, :password_confirmation"       # add password to the permission list
  end

  if $ancestry
    line << ", :ancestry"
  end

  if $content
    line << ", :content"
  end

  if $images
    line << ", :cover_image, :remove_cover_image, images: []"
  end

  line << ", :avatar, :remove_avatar" if $avatar

# s[/.*\(([^)]*)/,1]
  if $modelables.present?
    $modelables.each do |modelable|
      permit_string = ''
      assoc_controller = "app/controllers/admin/#{modelable.pluralize}_controller.rb"
      File.readlines(assoc_controller).each { |line| permit_string = line if (line[/permit/])}
      attributes_list = permit_string[/.*\(([^)]*)/,1]

      line << "\n#{TAB*4}#{modelable.pluralize}_attributes: ["
      line << "\n#{TAB*5}:id, #{attributes_list}"

      if modelable == $modelables.last
        line << "\n#{TAB*4}]"
      else
        line << "\n#{TAB*4}],"
      end
    end
  end
  line << "\n#{TAB*3})\n#{TAB*2}end"
  file.puts line

  file.puts "end"
  file.close
end
