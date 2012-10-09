Etsy.configure do |config|
  config.api_key = ENV['ETSY_API_KEY']
  config.api_secret = ENV['ETSY_API_SECRET']
end