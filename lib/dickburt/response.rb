class Dickburt::Response
  attr_accessor :message_type
  attr_accessor :body
  
  def initialize(body, message_type)
    @message_type = message_type
    @body = body
  end
  
  def to_json
    {:message => {:body => @body, :type => @message_type + "Message"}}.to_json
  end
end