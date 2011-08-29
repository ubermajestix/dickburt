class Dickburt::Message < Map
  
  attr_accessor :command
  attr_accessor :args
  
  def initialize(json)
    super(JSON.parse(json))
    puts self.inspect
    puts "="*45
    self
  end
  
  def process_command
    return unless @command
    # TODO make dickburt aware of users so he can respond to them.
    # I really don't like this setup of not having instances of the bot.
    # If i got an instance I could save things to it, like the user and message object
    # Then it wouldn't be as weird to process the command here on the message object
    @args ? Dickburt::Bot.send(@command, @args) : Dickburt::Bot.send(@command)
  end
  
  def user
    
  end
end