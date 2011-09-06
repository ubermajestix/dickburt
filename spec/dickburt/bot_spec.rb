require "spec_helper"

describe Dickburt::Bot do
  
  before(:each) do
    @message = Dickburt::Message.new({type: "TextMessage", body: "dickburt beerme"}.to_json)
    @user = Dickburt::User.new({name: "Human"}.to_json, campfire )
    @room = Dickburt::Room.new({name: 'Campfire Room'}, campfire)
    @dickburt = Dickburt::Bot.new(@message, @user, @room)
  end
  
  it "must deliver beer" do
    @dickburt.must_respond_to :beerme
    @dickburt.beerme.must_be_kind_of Dickburt::Response
  end
  
  it "must deliver images" do
    skip "use vcr to mock web response"
    @dickburt.must_respond_to :imageme
    @dickburt.imageme.must_be_kind_of Dickburt::Response
  end
  
  context ".parse_args" do
    it "must parse arguments from a message" do
      message = Dickburt::Message.new({type: "TextMessage", body: "dickburt imageme funny hipsters"}.to_json)
      dickburt = Dickburt::Bot.new(message, @user, @room)
      dickburt.parse_args.must_equal 'funny hipsters'
      
    end
  
    it "must return nil if no args exist" do
      message = Dickburt::Message.new({type: "TextMessage", body: "dickburt imageme"}.to_json)
      dickburt = Dickburt::Bot.new(message, @user, @room)
      dickburt.parse_args.must_be_nil
    end    
  end
  
  context 'imageme' do
  end
  
end
