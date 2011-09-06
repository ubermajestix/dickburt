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
    
    def find_user(user_id)
      user = users.detect{|u| u.id == user_id}
      raise Dickburt::Error, "user #{user_id} not found" unless user
      User.new(user.to_json, campfire)
    end
    
    def handle_failure
    
    end
  
  end
end