class Dickburt::Room < Map
  attr_accessor :campfire
  
  def initialize(room, campfire)
    super(room)
    @campfire = campfire
  end
  
  def speak(response)
    logger.info "speak: #{response.inspect}"
    speak = @campfire.http.post("/room/#{id}/speak.json", response.to_json)
    logger.info speak.status
    if speak.status >= 400 
      logger.error JSON.parse(speak.body).inspect
    end
  end
  
  def stream
    Twitter::JSONStream.connect(
      :path => "/room/#{id}/live.json",
      :host => 'streaming.campfirenow.com',
      :auth => "#{campfire.token}:x"
    )
  end
  
end