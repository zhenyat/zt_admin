begin
  if (Account.present? and not Account.exists?)
    Account.create email: 'anonym@example.ru', password: '123123123'
    puts "===== #{Account.count} 'Account' record(s) created"
  else
    puts "===== 'Account' seeding skipped"
  end
rescue
  puts "----- Achtung! Something went wrong..."
end