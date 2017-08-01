task :mail_reminders => :environment do
	puts "The task is raking."
	Reminder.where(mail_date: Date.today.beginning_of_day..Date.today.end_of_day).each do |reminder|
		puts reminder.name
		ReminderMailer.reminder_send(reminder.user, reminder).deliver_now
		reminder.create_mail_date
		puts reminder.mail_date
	end
	puts "The end."
end