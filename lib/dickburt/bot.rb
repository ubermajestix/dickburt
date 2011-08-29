class Dickburt::Bot
  attr_accessor :message
  attr_accessor :user
  attr_accessor :room
  def initialize(message, user, room)
    @message = message
    @user = user
    @room = room
  end
  
  def self.used_images
    @used_images ||= {}
  end
  
  def self.image_page
    @image_page ||= {}
  end
    
   def self.process(message, room, campfire)
    if message[:type] == 'TextMessage' && message.body.match(/\bdickburt\b/i)
      dickburt = Dickburt::Bot.new(message, Dickburt::User.new(message.user_id, campfire), room)
      command  = dickburt.parse_command
      args     = dickburt.parse_args
      if command
        response = args ? dickburt.send(command, args) : dickburt.send(command)
        room.speak(response)
      end
    end
  end
  
  def commands
    @commands ||= %w(imageme beerme hi fuckyeah)
  end
  
  def commands_regex
    Regexp.union(commands.map{|c| /\b#{c}\b/})
  end
  
  def parse_command
    command = commands.detect{|c| message.body.downcase.match(/\b#{c}\b/)}
    command = 'whatup' if message[:type] == 'EnterMessage'
    command
  end
  
  def parse_args
    reg = Regexp.union(/dickburt:?/, commands_regex)
    args = message.body.downcase.gsub(reg,'').strip
    args.empty? ? nil : args
  end
  
  def whatup
    Dickburt::Response.new("whatup #{user.name}", 'Text')
  end
  
  def fuckyeah
    Dickburt::Response.new('FUCKYEAH BUDDIE!', 'Text')
  end
  
  def imageme(query='funny pugs')
    image = google_image(query)
    if image
      Dickburt::Response.new(image, 'Upload') 
    else
      Dickburt::Response.new("couldn't find any pics of #{query}", 'Text') 
    end
  end
  
  def beerme
    Dickburt::Response.new('http://f.cl.ly/items/333i290f1x2N330u303N/beerme.png', 'Upload')
  end
  
  def hi
    whatup if rand(5) == 4
    fuckyeah if rand(10) == 4
    Dickburt::Response.new("Hi #{user.name}", 'Text')
  end
  
  def google_image(query='funny pugs', page=0)
    @search_server ||= Patron::Session.new
    @search_server.base_url = "https://ajax.googleapis.com/ajax/services/search"
    Dickburt::Bot.used_images[query] ||= []
    page = Dickburt::Bot.image_page[query].to_i + 1 if Dickburt::Bot.image_page[query].to_i > page
    Dickburt::Bot.image_page[query] = page
    uri = Addressable::URI.new
    uri.query_values = {:v => "1.0", :q => query, :rsz=>'8', :start=>page.to_s}
    puts "finding #{query} on page #{page}"
    response = @search_server.get("/images?#{uri.query}")
    if response.status < 400
      body = JSON.parse(response.body)
      if body["responseData"]
        results = JSON.parse(response.body)["responseData"]["results"] 
        results.each_with_index do |image, i|
          image = Map.new(image)
          # check to see if we've seen this image for this query
          next if Dickburt::Bot.used_images[query].include?(image.imageId)
          Dickburt::Bot.used_images[query] << image.imageId
          # check to make sure the image doesn't 404
          exists = image_exists?(image.url)
          next if exists == false
          # return the image
          @image_url = image.url
          break # cause we found an image
        end
      else
        @error= true
      end
    else
      @error = true
      puts "="*45
      puts response.status
      puts response.body.inspect
      puts "="*45
    end
    puts @image_url.inspect
    puts @error.inspect
    google_image(query, page+=1) unless @image_url or @error
    @image_url
  end
  
  def image_exists?(url)
    begin
      image = Patron::Session.new
      split_url = url.split("/",4)
      image_url = split_url.pop
      image.base_url = split_url.join("/")
      response = image.head("/#{image_url}")
      response.status < 400
    rescue Patron::ConnectionFailed, Patron::ConnectionFailed
      puts "="*45
      puts "DNE!"
      puts "="*45
      false
    end
  end
    
end
