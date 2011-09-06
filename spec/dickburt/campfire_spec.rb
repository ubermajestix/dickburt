require 'spec_helper'

describe Dickburt::Campfire do
  it "should take the subdomain as the host and format it" do
    c = Dickburt::Campfire.new(:host=>"everlater")
    c.host.must_equal "https://everlater.campfirenow.com"
  end
end