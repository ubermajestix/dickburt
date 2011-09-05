require 'dickburt/version'
require 'twitter/json_stream'
require 'patron'
require 'json'
require "addressable/uri"
require 'map'
require 'logging'
require 'fileutils'

module Dickburt
  require 'dickburt/bot'
  require 'dickburt/campfire'
  require 'dickburt/config'
  require 'dickburt/logger'
  require 'dickburt/message'
  require 'dickburt/response'
  require 'dickburt/retryable'
  require 'dickburt/room'
  require 'dickburt/server'
  require 'dickburt/user'
  class Error < StandardError; end;
  def self.logger
    @logger = Logging::Logger[self.name]
  end
  
end



