module Dickburt
  class User < Map
    attr_accessor :campfire
    include Logger
    def initialize(id, campfire)
      response = campfire.http.get("/users/#{id}.json")
      super(JSON.parse(response.body)["user"])
      @campfire = campfire
    end
  end
end