begin
  if (Sample.present? and not Sample.exists?)
    Sample.create!([
      { name:   'hemp_paste', 
        title:  'Паста конопляная Классическая 200 г',
        price:  288.00,
        quantity: 14
      },
      { name:   'hemp_mask_grey', 
        title:  'Серая конопляная маска 3-слойная',
        price:  198.00
      },
      { name:   'hemp_hat', 
        title:  'Шляпа оранжевая из конопли',
        price:  1088.00,
        quantity: 9
      },
      { name:   'hemp_bag', 
        title:  'Рюкзак из конопли Нарантан',
        price:  3188.00,
        quantity: 9
      }
    ])
    puts "===== #{Sample.count} 'Sample' record(s) created"
  else
    puts "===== 'Sample' seeding skipped"
  end
rescue
  puts "----- Achtung! Something went wrong..."
end