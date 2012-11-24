require File.expand_path("../../lib/rails-queue", __FILE__)

class Rails::QueueTest < ActiveSupport::TestCase
  test "module definition" do
    assert_kind_of Module, Rails::Queue
  end
end
