require 'dickburt/version'
require 'twitter/json_stream'
require 'patron'
require 'json'
require "addressable/uri"
require 'map'
require 'logging'

module Dickburt
  require 'dickburt/bot'
  require 'dickburt/campfire'
  require 'dickburt/message'
  require 'dickburt/response'
  require 'dickburt/room'
  require 'dickburt/server'
  def self.logger
    @logger = Logging::Logger[self.name]
  end
end



