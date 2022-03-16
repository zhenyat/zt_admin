begin
  if (User.present? and not User.exists?)
    User.create first_name: 'Bob',  last_name: 'Dummy',  role: 2, email: 'dummy@mail.ru',  password: '123123123', password_confirmation: '123123123'
    User.create first_name: 'Alex', last_name: 'Petrov', role: 0, email: 'alex@gmail.com', password: '123123123', password_confirmation: '123123123'
    puts "===== #{User.count} 'User' record(s) created"
  else
    puts "===== 'User' seeding skipped"
  end
rescue
  puts "----- Achtung! Something went wrong ('User' entity does not exist?)"
end