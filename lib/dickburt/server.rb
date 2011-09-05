module Dickburt
  module Server
    class << self
      include Logger
      include Retryable
    end
    def self.run(args={})
      logger.info "boom!"
      EventMachine::run do
        retryable(:tries => 5, :on => Patron::TimeoutError) do
          @campfire = Dickburt::Campfire.new(args)
          puts "="*45
          puts "Connected to #{@campfire.host} with token #{@campfire.token}"
          puts "="*45
          @room = @campfire.rooms.detect{|r| r.name.downcase.gsub(/\s/,'_') == args[:room].downcase.gsub(/\s/,'_')}
          @room.join
          puts "Ready for messages..."
          puts "="*45
        end
        stream = @room.stream
 
        stream.each_item do |item|
          message = Dickburt::Message.new(item)
          puts message.inspect
          Dickburt::Bot.process(message, @room, @campfire)
        end
 
        stream.on_error do |message|
          puts "ERROR: #{message.inspect}"
        end
 
        stream.on_max_reconnects do |timeout, retries|
          puts "Tried #{retries} times to connect."
          exit
        end
  
        trap("INT") do 
          @room.leave if @room
          EM.stop
        end  
  
      end
    end
  end
end