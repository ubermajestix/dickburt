require 'spec_helper'

describe Dickburt::Config do
  
  before(:each) do
    FileUtils.rm_rf("#{Dir.home}/.dickburt/config.yml", :noop=>true) 
  end
  
  it "should create the ~/.dickburt dir" do
  end
  
  it "should write the config when we add a token" do
    Dickburt::Config.set_token("shabam", 'boooooom')
    Dir.exists?("#{Dir.home}/.dickburt").must_equal true
    File.exists?("#{Dir.home}/.dickburt/config.yml").must_equal true
    Dickburt::Config.config.must_equal ({:shabam => {:token => "boooooom"}}) 
  end
  
  it "should read config" do
    Dickburt::Config.config.must_be_kind_of Hash
  end
  
end