require "bundler"

Bundler.setup :default, :development

require "minitest/spec"
require "minitest/autorun"
require "minitest/mock"

require 'fabrication'
require 'ffaker'

require "dickburt"

alias :context :describe

def user_mock
  mock = MiniTest::Mock.new
  mock.expect("name", "Human")
end

def campfire
  @campfire ||= Dickburt::Campfire.new(:host=>"everlater")
end