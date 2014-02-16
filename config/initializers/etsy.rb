# New (late 2013ish) Etsy API keys are now required
# to use HTTPS. Older keys can still get away with HTTP
Etsy.protocol = 'https'
Etsy.environment = :production
Etsy.api_key = ENV['ETSY_API_KEY']
Etsy.api_secret = ENV['ETSY_API_SECRET']
