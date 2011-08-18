module Dickburt
  class Server
    def self.run
      EventMachine::run do
        @campfire = Dickburt::Campfire.new
        puts "="*45
        puts "Connected to #{@campfire.host}"
  
        @room = @campfire.rooms.detect{|r| r.name == 'Dayjob'}
  
        puts "="*45
        puts "Connected to #{@room.name}(#{@room.id})"
        puts "Ready for messages..."
        puts "="*45
  
        stream = @room.stream
 
        stream.each_item do |item|
          message = Dickburt::Message.new(item)
          if message.to_lavender?
            @room.speak(message.process_command)
          end
        end
 
        stream.on_error do |message|
          puts "ERROR:#{message.inspect}"
        end
 
        stream.on_max_reconnects do |timeout, retries|
          puts "Tried #{retries} times to connect."
          exit
        end
  
        trap("INT") { EM.stop }
  
      end
    end
  end
end