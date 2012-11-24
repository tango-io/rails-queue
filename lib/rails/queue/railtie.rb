require "rails"

module Rails
  module Queue

    # Public: Initialize Rails 4 Queue
    class Railtie < ::Rails::Railtie

      # mixin the queue and queue_consumer to Configuration
      Rails::Application::Configuration.send :include,
        Rails::Queue::Configuration

      # mixin the queue and queue_consumer to Application with default Queue
      Rails::Application.send :include, Rails::Queue::Application

      # provide a `queue` accessor from the top-level module
      def Rails.queue
        application.queue
      end

      # initialize the configuration instance queue if needed
      config.after_initialize do |app|
        unless app.config.instance_variable_get(:"@queue")
          app.config.instance_variable_set(
            :"@queue", Rails::Queue::SynchronousQueue.new
          )
        end
      end

      # initialize the queue_consumer
      # copied from: railties/lib/rails/application/finisher.rb
      initializer :activate_queue_consumer, after: "finisher_hook" do |app|
        if app.config.queue.class == Rails::Queue::Queue
          app.queue_consumer = app.config.queue_consumer || app.config.queue.consumer
          app.queue_consumer.logger ||= Rails.logger if app.queue_consumer.respond_to?(:logger=)
          app.queue_consumer.start
          at_exit { app.queue_consumer.shutdown }
        end
      end

      # initialize ActionMailer queue configuration
      config.after_initialize do |app|
        app.config.action_mailer.queue ||= app.queue
      end

      # enable ActionMailer queued delivery
      ::ActiveSupport.on_load :action_mailer do
        class_attribute :queue
        self.queue = Rails::Queue::SynchronousQueue.new

        # override default implementation to provide a QueuedMessage
        # copied from Rails 4
        def self.method_missing(method_name, *args)
          if action_methods.include?(method_name.to_s)
            Rails::Queue::ActionMailer::QueuedMessage.new(queue, self, method_name, *args)
          else
            super
          end
        end
      end
    end

  end
end
