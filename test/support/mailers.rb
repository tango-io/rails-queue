# Original File: RAILS_ROOT/actionmailer/test/mailers/base_mailer.rb
class BaseMailer < ActionMailer::Base
  self.mailer_name = "base_mailer"

  default to: 'system@test.lindsaar.net',
          from: 'jose@test.plataformatec.com',
          reply_to: 'mikel@test.lindsaar.net'

  def welcome(hash = {})
    headers['X-SPAM'] = "Not SPAM"
    mail({subject: "The first email on new API!"}.merge!(hash))
  end
end

# Original File: RAILS_ROOT/actionmailer/test/mailers/async_mailer.rb
class AsyncMailer < BaseMailer
  self.queue = Rails::Queue::TestQueue.new
end
