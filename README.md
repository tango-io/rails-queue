# rails-queue

[![Build Status](https://secure.travis-ci.org/probablywrong/rails-queue.png)](https://travis-ci.org/probablywrong/rails-queue) [![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/probablywrong/rails-queue)

## Description

It's the `Rails.queue` [from Rails 4](https://github.com/rails/rails/blob/master/activesupport/lib/active_support/queueing.rb), backported to Rails 3.2+ for your Queueing pleasure.

> `Rails.queue` is the application's queue. You can push a job onto the queue by:
>
> ```
> Rails.queue.push job
> ```
>
> A job is an object that responds to `#run`. Queue consumers will pop jobs off of the queue and invoke the queue's `run` method.
>
> Note that depending on your queue implementation, jobs may not be executed in the same process as they were created in, and are never executed in the same thread as they were created in.
>
> If necessary, a queue implementation may need to serialize your job for distribution to another process. The documentation of your queue will specify the requirements for that serialization


## Requirements

This gem requires Rails 3.2+ and has been tested on the following versions:

* 3.2.8
* 3.2.9

This gem has been tested against the following Ruby versions:

* 1.9.2
* 1.9.3


## Installation

Add this line to your application's Gemfile:

```ruby
gem "rails-queue"
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install rails-queue
```


## Usage

The following queueing strategies are provided by default:

* `SynchronousQueue`
* `TestQueue`

The following queue consumer strategies are provided by default:

* `ThreadedQueueConsumer`

The threaded consumer will run jobs in a background thread in development mode or in a VM where running jobs on a thread in production mode makes sense.

When the process exits, the consumer pushes a `nil` onto the queue and joins the thread, which will ensure that all jobs are executed before the process finally dies.

_Note: In this port, classes that live under the `ActiveSupport::` namespace in Rails 4 have been moved to the `Rails::Queue::` namespace._

### Configuration

Rails will now have the following options available:

* `config.queue`
* `config.queue_consumer`
* `config.action_mailer.queue`

These can be customized in `config/application.rb` or by environment:

```ruby
# config/environments/production.rb

# Default the production mode queue to an synchronous queue. You will probably
# want to replace this with an out-of-process queueing solution.
config.queue = Rails::Queue::SynchronousQueue.new

# You will probably want to change the job queue consumer from the default.
config.queue_consumer = Rails::Queue::ThreadedQueueConsumer.new
```


### ActionMailer

Mail delivery from ActionMailer can be processed asynchronously using the Rails.queue.

By default, ActionMailer will use the application default Rails.queue strategy. This can be configured:

```ruby
# The queue that will be used to deliver the mail. The queue should expect a job
# that responds to run.
config.action_mailer.queue = Rails::Queue::SynchronousQueue.new
```


### Testing

In test mode, the Rails queue is backed by an Array so that assertions can be made about its contents. The test queue provides a `jobs` method to make assertions about the queue's contents and a `drain` method to drain the queue and run the jobs.

Jobs are run in a separate thread to catch mistakes where code assumes that the job is run in the same thread.

```ruby
# config/environments/test.rb

config.queue = Rails::Queue::TestQueue.new
```

### Alternate Providers

The Rails Queue implementation is designed to be pluggable and you may want to investigate other queue providers, such as:

* [resque-rails](https://github.com/jeremy/resque-rails)
* [Sidekiq](https://github.com/mperham/sidekiq/tree/rails4)


## Resources

The following are some resources from around the Internet which introduce the Rails Queue:

_Note: Many of these are, or will be soon, out of date._

* [Ruby on Rails 4.0 Release Notes](http://edgeguides.rubyonrails.org/4_0_release_notes.html)
* [Rails 4.0 Sneak Peek: Queueing](http://reefpoints.dockyard.com/ruby/2012/06/25/rails-4-sneak-peek-queueing.html)
* [New in Rails 4.0: Rails Queue](http://www.3magine.com/blog/new-in-rails-4-0-rails-queue/)


## A note on spelling

Yes, there are two spelling options. We defer to research provided by [XKCD](http://xkcd.com/853/).


## Authors

This was written/extracted as part of an ongoing yak-shave known as "We're Probably Wrong", a production of:

* [@elskwid](https://github.com/elskwid) [![endorse](http://api.coderwall.com/elskwid/endorsecount.png)](http://coderwall.com/elskwid)
* [@phlipper](https://github.com/phlipper) [![endorse](http://api.coderwall.com/phlipper/endorsecount.png)](http://coderwall.com/phlipper)


## Contributors

Many thanks go to the following who have contributed to making this gem even better:

* **[@rails](https://github.com/rails)**
    * for making this all possible in the first place


## Contributing

1. [Fork it](https://github.com/probablywrong/rails-queue/fork_select)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. [Create a Pull Request](hhttps://github.com/probablywrong/rails-queue/pull/new)


## License

**rails-queue**

* Freely distributable and licensed under the [MIT license](http://probablywrong.mit-license.org/2012/license.html).
* Copyright (c) 2012 We're Probably Wrong (github@wereprobablywrong.com)
* http://wereprobablywrong.com/

**rails**

* Ruby on Rails is released under the [MIT License](http://www.opensource.org/licenses/MIT).
