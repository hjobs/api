OmniAuth.config.logger = Rails.logger
OmniAuth.config.full_host = "http://localhost:9080"

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], {
    :access_type => "online",
    :name => "google",
    :scope => "userinfo.email,userinfo.profile",
    :prompt => "select_account",
    :image_aspect_ratio => "square",
    :image_size => 50,
    :redirect_uri => "http://localhost:9080/auth/google/callback"
  }
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET']
  provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']
  
end