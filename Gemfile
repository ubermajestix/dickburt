source "http://rubygems.org"

# Specify your gem's dependencies in camper_van.gemspec
gemspec

# specified here rather than in gemspec because they're
# for local mac development only
group :development do
  gem "rb-fsevent"
  gem "growl"
  gem "guard"
  # 0.4.0.rc versions are still git-only
  gem "guard-minitest", :git => "https://github.com/guard/guard-minitest.git"
  gem "fabrication"
  gem "ffaker", :require => "ffaker"
  gem 'vcr'
  gem "fakeweb"
end
