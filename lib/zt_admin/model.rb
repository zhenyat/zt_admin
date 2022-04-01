#!/usr/bin/env ruby
#################################################################################
#   model.rb
#
#   Updates Model file: app/models/<model>.rb
#
#   26.12.2020  ZT
#   01.04.2022  Polymorphic code
################################################################################
module ZtAdmin
  relative_path = 'app/models'    # models directory
  models_path   = "#{AppRoot}/#{relative_path}"
  action_report relative_path

  relative_path = "app/models/#{$name}.rb"  # Model file
  absolute_path = "#{AppRoot}/#{relative_path}"
  action_report relative_path

  FileUtils.cp "#{absolute_path}", "#{models_path}/backup.rb"

  file_in = File.open "#{models_path}/backup.rb", "r"
  lines   = file_in.readlines
  file_in.close
  
  file_out = File.open "#{absolute_path}", "w"

  lines.each do |line|
    if line =~ /< ApplicationRecord/
      file_out.puts line

      if $modelables.present?
        $modelables.each do |modelable|
          file_out.puts "#{TAB}has_many :#{modelable.pluralize}, as: #{modelable}able"
        end
        file_out.puts ""
        $modelables.each do |modelable|
          file_out.puts "#{TAB}accepts_nested_attributes_for :#{modelable.pluralize}"
        end
        file_out.puts ""
        $modelables.each do |modelable|
          file_out.puts "#{TAB}validates_associated :#{modelable.pluralize}"
        end
      end
      
      file_out.puts "#{TAB}include Positionable"      if $position
      file_out.puts "#{TAB}include ImagesHandleable"  if $images
      file_out.puts "#{TAB}include Heritable"         if $ancestry
      file_out.puts "#{TAB}has_ancestry"              if $ancestry
      file_out.puts "#{TAB}has_rich_text :content"    if $content\
    else
      file_out.puts line    # Just copy an original line
    end
  end
  file_out.close
  FileUtils.rm "#{models_path}/backup.rb"
end
    # elsif line.match("has_ancestry")
      # Skip this line