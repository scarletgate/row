class ApplicationMailer < ActionMailer::Base
  default from: ENV['TOMAIL']
  layout 'mailer'
end
