if Rails.env.development? || Rails.env.production?
   ActionMailer::Base.delivery_method = :smtp
   ActionMailer::Base.smtp_settings = {
     address:        'smtp.sendgrid.net',
     port:           '2525',
     authentication: :plain,
     user_name:      Rails.application.secrets.sendgrid_username,
     password:       Rails.application.secrets.sendgrid_password,
     domain:         'heroku.com',
     enable_starttls_auto: true
   }
 end
