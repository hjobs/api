# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

require 'rack/cors'
use Rack::Cors do
  allow do
    origins ENV["RAILS_ENV"] == "production" ? 'https://www.hjobs.hk' : %w(https://webserver.hjobs.hk http://localhost:3000)
    resource '*',
        :headers => :any,
        :methods => [:get, :post, :delete, :put, :options, :patch]
  end
end

use Rack::Session::Cookie, secret: ENV["COOKIES_SECRET"]
