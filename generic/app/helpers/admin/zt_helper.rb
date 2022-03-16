module Admin::ZtHelper
  # Sorts array of objects by the Attribute (if passed)
  def sort_objects objects_array, attribute=nil
    if attribute.nil?
      objects_array
    else
      objects_array.sort! { |a,b| eval("a.#{attribute} <=> b.#{attribute}") }
    end
  end

  # Selects a status mark to be displayed
  def status_mark status
    if status == 'active'
      image_tag('admin/check_mark.png', size: '12x15', alt: 'Active')
    else
      image_tag('admin/minus_mark.png', size: '12x15', alt: 'Archive')
    end
  end

  # Selects a hot mark to be displayed
  def hot_mark hot
    if hot 
      image_tag('admin/check_mark.png', size: '12x15', alt: 'True')
    else
      image_tag('admin/minus_mark.png', size: '12x15', alt: 'False')
    end
  end
end
