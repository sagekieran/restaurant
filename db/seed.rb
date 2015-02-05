require 'pg'
require 'active_record'
require 'pry'

Dir["../models/*.rb"].each do |file|
  require_relative file
end
 ActiveRecord::Base.establish_connection(
adapter: :postgresql,
database: :restdb,
host: :localhost,
port: 5432
)

Meal.create(
  name: "Mac n Cheese",
  cuisine_type: "Delicious",
  price: 5,
  created_at: Time.now
  )
  
Party.create(
  t_number: 1,
  guests: 2,
  paid: false,
  created_at: Time.now
  )