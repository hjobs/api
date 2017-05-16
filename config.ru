# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

require 'rack/cors'
use Rack::Cors do
  allow do
    origins ENV["RAILS_ENV"] == "production" ? 'https://www.hjobs.hk' : 'https://webserver.hjobs.hk'
    resource '*',
        :headers => :any,
        :methods => [:get, :post, :delete, :put, :options, :patch]
  end
end

use Rack::Session::Cookie, secret: ENV["COOKIES_SECRET"]
