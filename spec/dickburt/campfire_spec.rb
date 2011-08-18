require 'spec_helper'

describe Dickburt::Campfire do
  it "should take the subdomain as the host and format it" do
    Dickburt::Campfire.new(:host=>"everlater").host.must_equal "http://everlater.campfirenow.com"
  end
end