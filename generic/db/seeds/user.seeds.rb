begin
  if (User.present? and not User.exists?)
    User.create first_name: 'Bob',  last_name: 'Dummy', role: 2, email: 'dummy@example.com', password: '123123123', password_confirmation: '123123123'
    User.create first_name: 'Alex', last_name: 'Black', role: 0, email: 'alex@example.com',  password: '123123123', password_confirmation: '123123123'
    puts "===== #{User.count} 'User' record(s) created"
  else
    puts "===== 'User' seeding skipped"
  end
rescue StandardError, AnotherError => e
  puts "----- Achtung! Something went wrong..."
  puts "#{e.inspect}"
end