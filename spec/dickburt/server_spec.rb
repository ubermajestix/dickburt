require "spec_helper"

describe Dickburt::Server do
  it "has a run module method" do
    Dickburt::Server.must_respond_to :run
  end

end
