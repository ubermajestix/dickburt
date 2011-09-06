module Dickburt
  class Room < Map
    attr_accessor :campfire
    attr_accessor :response
    include Logger
    def initialize(room, campfire)
      super(room)
      @campfire = campfire
    end
  
    def response=(response)
      puts "="*45
      puts response.status
      puts "="*45
      if response.status >= 400 
        logger.error JSON.parse(speak.body).inspect
      end
    end
  
    def speak(response)
      response = @campfire.http.post("/room/#{id}/speak.json", response.to_json)
    end
  
    def join
      response = @campfire.http.post("/room/#{id}/join.json", {})
    end
    
    def leave
      response = @campfire.http.post("/room/#{id}/leave.json", {})
    end
  
    def stream
      Twitter::JSONStream.connect(
        :path => "/room/#{id}/live.json",
        :host => 'streaming.campfirenow.com',
        :auth => "#{campfire.token}:x"
      )
    end
    
    # Returns an Array of current users for the room.
    def users
      response = @campfire.http.get("/room/#{id}.json")
      room = Map.new(JSON.parse(response.body)["room"])
      room.users
    end
    
    # Looks up the user by user_id for the current users in the room
    #
    #  user_id - String 37signals user id
    #
    # Returns a Dickburt::User if it finds that user in the room
    # Raises an error if they can't be found.
    def find_user(user_id)
      user = users.detect{|u| u.id == user_id}
      raise Dickburt::Error, "user #{user_id} not found" unless user
      User.new(user.to_json, campfire)
    end
    
    def handle_failure
    
    end
  
  end
end