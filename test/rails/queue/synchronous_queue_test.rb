# Original File: RAILS_ROOT/activesupport/test/queueing/synchronous_queue_test.rb
require "support/active_support_abstract_unit"
require "rails-queue"

class SynchronousQueueTest < ActiveSupport::TestCase
  class Job
    attr_reader :ran
    def run; @ran = true end
  end

  class ExceptionRaisingJob
    def run; raise end
  end

  def setup
    @queue = Rails::Queue::SynchronousQueue.new
  end

  def test_runs_jobs_immediately
    job = Job.new
    @queue.push job
    assert job.ran

    assert_raises RuntimeError do
      @queue.push ExceptionRaisingJob.new
    end
  end
end
