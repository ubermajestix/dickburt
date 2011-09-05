# Store the campfire api token b/c I'm sick of looking that shit up.
# I know the host and room I want to access, but not the token, so if the token
# is provided, store it - tokens are uniq by host - so store it per host.
# Provides a nice config hash that we build up from the command line to hand off to Dickburt::Server.

module Dickburt
  module Config

    class << self
      
      # Provides a nice config hash that we build up from the command line to hand off to Dickburt::Server.
      # This is only ever called bin/dickburt. That script raises errors for missing host and room, so its
      # a bit redundant redundant to check that here.
      def config_hash(host, room)
        token = config[host.to_sym][:token] if config[host.to_sym]
        unless token
          raise Dickburt::Error, "You need to provide an api token.\n Just add: --token yourtokenfromcampfire to the command line args.\n The token will get stored in ~/.dickburt/config.yml for next time so you don't have to remember it"
        end
        { host:   host, 
          token:  token, 
          room:   room.downcase.gsub(/\s/,'_') }
      end
      
      # Public: Stores the given token for the given host.
      # Will not raise an error if the token is not given, leaves that up to bin/dickburt.
      def set_token(host, token=nil)
        if token
          config[host.to_sym] = {:token => token}
          write
        end
      end
      
      # Reads the config, or gives you an empty hash.
      def config
        ensure_config_exists
        @config ||= (YAML.load_file(config_file) || {})
      end
      
    private
      
      # Make sure the config dir and config file are on disk.
      def ensure_config_exists
        FileUtils.mkdir(config_dir)  unless Dir.exists?(config_dir)
        FileUtils.touch(config_file) unless File.exists?(config_file)
      end
      
      def config_file
        "#{config_dir}/config.yml"
      end
      
      def config_dir
        "#{Dir.home}/.dickburt"
      end
      
      # Writes the @config as yaml to disk.
      def write
        ensure_config_exists
        File.open(config_file, "wb"){|f| f.write @config.to_yaml}
      end
      
    end
  end
end
