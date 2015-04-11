#TODO fill in creds
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, 'FACEBOOK_KEY', 'FACEBOOK_SECRET'
  provider :twitter, 'API_KEY', 'API_SECRET'
end