require "spec_helper"

describe Dickburt::Bot do
  it "must deliver beer" do
    Dickburt::Bot.must_respond_to :beerme
    Dickburt::Bot.imageme.must_be_kind_of Dickburt::Response
  end
  
  it "must deliver images" do
    Dickburt::Bot.must_respond_to :imageme
    Dickburt::Bot.imageme.must_be_kind_of Dickburt::Response
  end
  
  it "must parse arguments" do
    Dickburt::Bot.parse_args('dickburt imageme funny hipsters').must_equal 'funny hipsters'
    Dickburt::Bot.parse_args('dickburt: imageme ').must_be_nil
  end
  
  context 'imageme' do
  end
  
end
