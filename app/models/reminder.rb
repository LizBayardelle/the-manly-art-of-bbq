class Reminder < ActiveRecord::Base
  belongs_to :user
  before_save :create_mail_date
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  
  def create_mail_date
    @schedule = IceCube::Schedule.new(self.event_date)
  	case self.repeating
  	when "Weekly"
  		@schedule.add_recurrence_rule(
            IceCube::Rule.weekly
        )
  	when "Monthly"
  		@schedule.add_recurrence_rule(
            IceCube::Rule.monthly.day_of_month(self.event_date.day)
        )
  	when "Yearly"
  		@schedule.add_recurrence_rule(
            IceCube::Rule.yearly.day_of_year(self.event_date.yday)
        )
  	end
    if self.repeating
        self.event_date = @schedule.next_occurrence(Time.current)
    end
    self.mail_date = self.event_date  - 7.days
  end
  
end
