class Dickburt::Response
  attr_accessor :message_type
  attr_accessor :body
  
  def initialize(body, message_type)
    @message_type = message_type
    @body = body
  end
  
  def to_campfire_hash
    {:message => {:body => @body, :type => @message_type + "Message"}}
  end
  
  def to_json
    self.to_campfire_hash.to_json
  end
end