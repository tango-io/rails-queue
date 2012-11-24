module Rails
  module Queue
    module Application
      extend ::ActiveSupport::Concern

      included do
        attr_accessor :queue_consumer
        attr_writer :queue
      end

      def queue #:nodoc:
        @queue ||= config.queue || Rails::Queue::Queue.new
      end

    end
  end
end
