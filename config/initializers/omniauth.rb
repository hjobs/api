OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV["GOOGLE_CLIENT_ID"], ENV["GOOGLE_CLIENT_SECRET"], {
    :access_type => "online",
    :name => "google",
    :scope => "userinfo.email,userinfo.profile",
    :prompt => "select_account",
    :image_aspect_ratio => "square",
    :image_size => 200
  }
  provider :facebook, ENV['FACEBOOK_KEY'], ENV['FACEBOOK_SECRET'], {
    :image_size => "large"
  }
  provider :linkedin, ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET']
  
end