# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "dickburt/version"
Gem::Specification.new do |s|
  s.name        = "dickburt"
  s.version     = Dickburt::VERSION
  s.authors     = ["Tyler Montgomery"]
  s.email       = ["tyler@everlater.com"]
  s.homepage    = ""
  s.summary     = %q{Campfire bot}
  s.description = %q{Dickburt finds pugs}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency "eventmachine"       , "~> 0.12.10"
  s.add_dependency "patron"             , "~> 0.4.11"
  s.add_dependency "logging"            , "~> 1.5.1"
  s.add_dependency "trollop"            , "~> 1.16.2"
  s.add_dependency 'twitter-stream'     , "~> 0.1.14"
  s.add_dependency 'json'               , "~> 1.5.1"
  s.add_dependency "addressable"        , "~> 2.2.6"
  s.add_dependency 'map'                , "~> 4.3.0"

  s.add_development_dependency "minitest", "~> 2.2.2"
end
