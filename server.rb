Dir["models/*.rb"].each do |file|
  require_relative file
end


class Restaurant < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  enable :sessions

  get '/console' do
    Pry.start(binding)
  end

  get '/' do
    erb :index
  end

  get '/meals' do
    @meals = Meal.all
    erb :'food/meals'
  end

  get '/meals/new' do
    erb :'food/newmeal'
  end

  get '/meals/:id' do |id|
    @meal = Meal.find(id)
    erb :'food/meal'
  end

  post '/meals' do
    meal = Meal.create(params[:meal])
    redirect to("/meals/#{meal.id}")
  end

  get '/meals/:id/edit' do |id|
    @meal = Meal.find(id)
    erb :'food/editmeal'
  end

  patch '/meals/:id' do |id|
    meal = Meal.find(id)
    meal.update(params[:meal])
    redirect to("/meals/#{meal.id}")
  end

  delete '/meals/:id' do |id|
    meal = Meal.find(id)
    meal.destroy
    redirect to('/meals')
  end

  get '/parties' do
    @parties = Party.all
    erb :'party/parties'
  end

  get '/parties/new' do
    erb :'party/newparty'
  end

  get '/parties/:id' do |id|
    @meals = Meal.all
    @party = Party.find(id)
    erb :'party/party'
  end

  get '/parties/:id/order' do |id|
    @party = Party.find(id)
    @meals = Meal.all
    erb :'order/neworder'
  end

  get '/parties/:id/receipt' do |id|
    @party = Party.find(id)
    erb :"party/receipt"
  end

  get '/parties/:id/close' do |id|
    @party = Party.find(id)
    erb :"party/close"
  end

  post '/parties/:id/close' do |id|
    party = Party.find(id)
    party.update(paid: true, tip: params[:tip]['amount'])
    redirect to('/parties')
  end

  post '/parties' do
    party = Party.create(params[:party])
    redirect to("/parties/#{party.id}")
  end

  get '/parties/:id/edit' do |id|
    @party = Party.find(id)
    erb :'party/editparty'
  end

  patch '/parties/:id' do |id|
    party = Party.find(id)
    party.update(params[:party])
    redirect to("parties/#{party.id}")
  end

  delete '/orders/:id' do |id|
    party = Party.find(id)
    party.destroy
    redirect to('/parties')
  end

  get '/orders' do
    @orders = Order.all
    erb :'order/orders'
  end

  get '/orders/:id' do |id|
    @order = Order.find(id)
    erb :'order/order'
  end

  post '/orders' do
    order = Order.create(params[:order])
    party = order.party.id
    redirect to("/orders/#{order.id}")
  end

  get '/orders/:id/edit' do |id|
    @order = Order.find(id)
    erb :'order/editorder'
  end

  patch '/orders/:id' do |id|
    order = Order.find(id)
    order.update(params[:order])
    redirect to("/orders/#{order.id}")
  end

  delete '/orders/:id' do |id|
    order = Order.find(id)
    order.destroy
    redirect to("/orders")
  end

  get '/tips' do
    @tips = 0.00
    partys = Party.all
    partys.each do |party|
      @tips += party.tip.to_f
    end
    erb :tips
  end

end
