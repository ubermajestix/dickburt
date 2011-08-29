require "bundler"

Bundler.setup :default, :development

require "minitest/spec"
require "minitest/autorun"
require "minitest/mock"

require 'fabrication'
require 'ffaker'
require "dickburt"

alias :context :describe
