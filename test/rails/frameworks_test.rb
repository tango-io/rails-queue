require "support/isolation_abstract_unit"
require 'set'

module ApplicationTests
  class FrameworksTest < ActiveSupport::TestCase
    include ActiveSupport::Testing::Isolation

    def setup
      build_app
      boot_rails
      FileUtils.rm_rf "#{app_path}/config/environments"
    end

    def teardown
      teardown_app
    end

    test "uses the default queue for ActionMailer" do
      require "#{app_path}/config/environment"
      assert_kind_of Rails::Queue::Queue, ActionMailer::Base.queue
    end

    test "allows me to configure queue for ActionMailer" do
      app_file "config/environments/development.rb", <<-RUBY
        AppTemplate::Application.configure do
          config.action_mailer.queue = Rails::Queue::TestQueue.new
        end
      RUBY

      require "#{app_path}/config/environment"
      assert_kind_of Rails::Queue::TestQueue, ActionMailer::Base.queue
    end

  end
end
