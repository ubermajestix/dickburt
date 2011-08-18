class Dickburt::Campfire
  attr_accessor :token
  attr_accessor :host
  
  class Error < StandardError; end;
  
  def initialize(args={})
    @token = args[:token] 
    @host = args[:host]
  end
  
  def http
    @http ||= Patron::Session.new
    @http.base_url = host
    @http.headers["Content-Type"] = "application/json"
    @http.username = token 
    @http.password = "x"
    @http
  end
  
  def rooms
    return @rooms if @rooms
    response = http.get("/rooms.json")
    @rooms = []
    if response.status < 400
      @rooms = JSON.parse(response.body)['rooms'] 
      @rooms.collect! do |room|
        Dickburt::Room.new(room, self)
      end
    else
      raise Dickburt::Campfire::Error, response.status + ": " + response.body
    end
  end
  
end