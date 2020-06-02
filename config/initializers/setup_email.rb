ActionMailer::Base.smtp_settings = {
  address: 'smtp.sendgrid.net',
  port: '587',
  authentication: :plain,
  user_name: 'irineutfilho' || ENV['SENDGRID_USERNAME'],
  password: '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' || ENV['SENDGRID_PASSWORD'],
  domain: 'heroku.com',
  enable_starttls_auto: true
}
ActionMailer::Base.delivery_method = :smtp
