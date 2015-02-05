require 'bundler'
Bundler.require :default

use Rack::MethodOverride

set :database, {
  adapter: "postgresql", database: "restdb",
  host: "localhost", port: 5432
}

require './server.rb'
run Restaurant