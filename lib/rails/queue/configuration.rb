module Rails
  module Queue
    module Configuration
      extend ::ActiveSupport::Concern

      included do
        attr_accessor :queue, :queue_consumer
      end

    end
  end
end
