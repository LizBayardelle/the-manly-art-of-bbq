class ReminderMailer < ApplicationMailer
  default from: "man@manlyartofbbq.com"
  
  def reminder_send(user, reminder)
    @user = user
    @reminder = reminder
    
    mail(to: user.email, subject: "Reminder! #{reminder.name} is fast approaching!")
  end
end
