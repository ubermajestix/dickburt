class Dickburt::Message < Map
  
  attr_accessor :command
  
  def initialize(json)
    super(JSON.parse(json))
    puts self.inspect
    self
  end
  
  def process_command
    return unless @command
    Dickburt::Bot.send(@command)
  end
  
  def to_dickburt?
    @lavender ||= self[:type] == 'TextMessage' && body.match(/^dickburt\:/i)
    @command = Dickburt::Bot.parse_command(body) if @lavender
    @lavender
  end
end