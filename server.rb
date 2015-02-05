Dir["models/*.rb"].each do |file|
  require_relative file
end

class Restaurant < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  
  get '/console' do 
    Pry.start(binding)
  end
  
  
end


