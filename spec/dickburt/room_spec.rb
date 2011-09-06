require 'spec_helper'

describe Dickburt::Room do
  context "handling failure" do
    before :each do
      @response = Map.new(:status => 401, :body => "you fucked up")
      @room = Dickburt::Room.new({name: 'Campfire Room'}, campfire)
    end

    it "handles failure if the response is bad" do
      skip
      @room.response = @response
    end
  end
end