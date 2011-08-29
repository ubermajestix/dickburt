require 'spec_helper'

describe Dickburt::Campfire do
  it "should fabricate something useful" do
    campfire = Fabricate(:campfire)
    puts "="*45
    puts campfire.inspect
    puts "="*45
    campfire.token.must_match (/boo/)
  end
  
  it "should take the subdomain as the host and format it" do
    c = Dickburt::Campfire.new(:host=>"everlater")
    c.host.must_equal "https://everlater.campfirenow.com"
  end
end