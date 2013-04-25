$:.push File.expand_path("../lib", __FILE__)

require "rails/queue/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails-queue"
  s.version     = Rails::Queue::VERSION
  s.authors     = ["Phil Cohen", "Don Morrison"]
  s.email       = ["github@phlippers.net", "elskwid@gmail.com"]
  s.homepage    = "http://wereprobablywrong.com/rails-queue"
  s.summary     = "Rails.queue (from Rails 4), backported to Rails 3.2+"
  s.description = "Rails.queue (from Rails 4), backported to Rails 3.2+"

  s.files = Dir["lib/**/*"] + %w[LICENSE.txt Rakefile README.md]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.2"
end
