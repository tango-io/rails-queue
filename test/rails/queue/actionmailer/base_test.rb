# Original File: RAILS_ROOT/actionmailer/test/base_test.rb
require "support/action_mailer_abstract_unit"
require "rails-queue"
require "support/mailers"

class BaseTest < ActiveSupport::TestCase
  def teardown
    ActionMailer::Base.asset_host = nil
    ActionMailer::Base.assets_dir = nil
  end

  test "delivering message asynchronously" do
    AsyncMailer.delivery_method = :test
    AsyncMailer.deliveries.clear

    AsyncMailer.welcome.deliver
    assert_equal 0, AsyncMailer.deliveries.length

    AsyncMailer.queue.drain
    assert_equal 1, AsyncMailer.deliveries.length
  end
end
