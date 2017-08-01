class ReminderMailerJob < ActiveJob::Base
  queue_as :default

  def perform(user, reminder)
    ReminderMailer.reminder_send(user, reminder).deliver
  end
end
