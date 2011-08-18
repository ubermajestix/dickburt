module Dickburt
  class Server
    def self.run(args={})
      EventMachine::run do
        @campfire = Dickburt::Campfire.new(args)
        puts "="*45
        puts "Connected to #{@campfire.host} with token #{@campfire.token}"
  
        @room = @campfire.rooms.detect{|r| r.name == 'Dayjob'}
        @room.join
        puts "="*45
        puts "Connected to #{@room.name}(#{@room.id})"
        puts "Ready for messages..."
        puts "="*45
  
        stream = @room.stream
 
        stream.each_item do |item|
          puts "="*45
          puts 'boom'
          puts "="*45
          message = Dickburt::Message.new(item)
          puts message.inspect
          if message.to_dickbert?
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