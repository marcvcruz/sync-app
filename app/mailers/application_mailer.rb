class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@sync-app.com'
  layout 'mailer'
end
