class Dickburt::Room < Map
  attr_accessor :campfire
  
  def initialize(room, campfire)
    super(room)
    @campfire = campfire
  end
  
  def speak(response)
    puts "="*45
    puts "speak: #{response.inspect}"
    puts response.to_json
    puts "="*45
    speak = @campfire.http.post("/room/#{id}/speak.json", response.to_json)
    puts speak.status
    puts speak.body.inspect
  end
  
  def stream
    Twitter::JSONStream.connect(
      :path => "/room/#{id}/live.json",
      :host => 'streaming.campfirenow.com',
      :auth => "#{campfire.token}:x"
    )
  end
  
end