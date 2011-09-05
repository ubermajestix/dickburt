Dickburt: A campfire bot
========================
  
    gem install dickburt
    
    dickburt desertbeaver the_overlook --token the_token_for_your_bot_user

Connecting to Campfire™
-----------------------
Dickburt runs from the command line, he gets installed when the gem gets installed. Connecting him to your campfire requires a few things.

First, you need a user for your bot. Go make a user, you'll need an email for your bot, but I'll assume you know how to make an email and signup for campfire. Once you've signed up and signed in as your bot, you're going to need to find the API token. Click "My info" and the [API token is pretty easy to spot](http://cl.ly/3W0r1H1h3a281z1a1C00 "Spotting the api token").

Second, the command line args are:

1. The subdomain of the campfire you want to join, so, in the example above we're trying to join http://desertbeaver.campfirenow.com

2. The campfire room we want to join, downcased and spaces replaced with underscores. So again in the above example the_overlook is means we'll join The Overlook room. Pretty easy. 

3. The last argument is the API token. Dickburt will store the api token in ~/.dickburt/config.yml after the first time you give him a token for a subdomain. Note! API Tokens are unique by subdomain. 
  
Commands
--------
Right now, this sucks, but you have to say "dickburt <somecommand>" or "somecommand blah lbah blah dickburt". You just have to say a command and dickburt in the same message. 
  
His commands are really limited but it is easy to make new ones.
  
  - hi
  - imageme (takes a query)
  - beerme
  - whatup
  - fuckyeah
  
Examples
--------

    Tyler: dickburt imageme hipster ferrets
    # => will upload the first image it finds for "hipster ferrets" on google image search
    
    Tyler: dickburt whatup
    # => dickburt: whatup Tyler