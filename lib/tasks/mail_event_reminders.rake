task :mail_event_reminders => :environment do
	puts "The task is raking."

	Event.where(reminder: true, start_time: Date.today.beginning_of_day + 7.days..Date.today.end_of_day + 7.days).each do |event|
		puts event.name
		ReminderMailer.reminder_send(event.user, event).deliver_now
	end

	puts "That was all the single events. Now for the repeating ones."

	Event.where(reminder: true).each do |event|
		if Event.schedule.occurs_on?(Date.today)
			ReminderMailer.reminder_send(event.user, event).deliver_now
		end
	end

	puts "The end."
end