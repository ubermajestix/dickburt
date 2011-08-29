require 'spec_helper'

describe Dickburt::Room do
  context "handling failure" do
    before :each do
      @response = Map.new(:status => 401, :body => "you fucked up")
      @room = Fabricate(:room)
    end

    it "handles failure if the response is bad" do
      @room.response = @response
    end
  end
end