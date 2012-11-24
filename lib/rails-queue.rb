require "active_support/concern"

$: << File.expand_path("../", __FILE__)

require "rails/queue/configuration"
require "rails/queue/application"
require "rails/queue/queue"
require "rails/queue/action_mailer/queued_message"

require "rails/queue/railtie"

module Rails
  module Queue
  end
end
