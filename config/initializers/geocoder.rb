Geocoder.configure(

  # geocoding service (see below for supported options):
  #:lookup => :google,
  :lookup => :mapquest,

  # to use an API key:
  :api_key => ENV['MAPQUEST_API_KEY'],

  # geocoding service request timeout, in seconds (default 3):
  #:timeout => 5,

  # set default units to kilometers:
  :units => :km,

  # caching (see below for details):
  #:cache => Redis.new,
  #:cache_prefix => "..."

)