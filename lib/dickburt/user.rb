module Dickburt
  class User < Map
    attr_accessor :campfire
    include Logger
    def initialize(json, campfire)
      super(JSON.parse(json))
      @campfire = campfire
    end
  end
end