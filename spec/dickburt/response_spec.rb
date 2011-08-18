require 'spec_helper'
describe Dickburt::Response do
  before :each do
    @response = Dickburt::Response.new("beer", "Text")
  end
  
  it "should give me a hash for campfire" do
    @response.to_campfire_hash.must_be_kind_of Hash
    @response.to_campfire_hash.keys.must_include :message
  end
  
  it "should respond to to_json with the appropriate hash" do
    JSON.parse(@response.to_json).keys.must_include "message"
  end
end