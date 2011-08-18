class Dickburt::Bot
  class << self
    def commands
      @commands ||= %w(imageme beerme)
    end
    
    def parse_command(text)
      commands.detect{|c| text.match(c)}
    end
    
    def imageme
      puts "="*45
      puts 'image me!!!!'
      puts "="*45
      url = google_image('funny pugs')
      Response.new(url, 'Upload')
    end
    
    def beerme
      Response.new('http://f.cl.ly/items/333i290f1x2N330u303N/beerme.png', 'Upload')
    end
    
    def google_image(query)
      @search_server = Patron::Session.new
      @search_server.base_url = "https://ajax.googleapis.com/ajax/services/search"
      @used_images ||= [] 
      uri = Addressable::URI.new
      uri.query_values = {:v => "1.0", :q => query}
      response = @search_server.get("/images?#{uri.query}")
      if response.status < 400
        results = JSON.parse(response.body)["responseData"]["results"]
        results.each do |image|
          image = Map.new(image)
          unless @used_images.include?(image.imageId)
            @used_images << image.imageId
            return image.url
          end
        end
      end
    end
    
  end
end