require 'bundler'
Bundler.require :default

use Rack::MethodOverride

if ENV['APP_ENV'] == 'production'
  set :database, {
    adapter: "postgresql",
    database: "restdb"
  }
else
  set :database, {
    adapter: "postgresql",
    database: "restdb",
    host: 'localhost',
    port: 5432
  }

require './server.rb'
run Restaurant
