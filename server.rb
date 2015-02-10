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
    @servers = Server.all
    erb :login
  end

  post '/login' do
    id = params[:server]['id']
    password = params[:server]['password']
    server = Server.find(id)
    if server.password == password
      session[:server_id] = server.id
      redirect to('/index')
    else
      redirect to('/')
    end
  end

  get '/index' do
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
    name = params[:meal]['name']
    check = Meal.check(name)
    if check
      meal = Meal.create(params[:meal])
      redirect to("/meals/#{meal.id}")
    else
      erb :mealoops
    end
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
    @server_id = session[:server_id]
    @parties = Party.all
    erb :'party/parties'
  end

  get '/parties/new' do
    @available = []
    tables = Teble.all
    tables.each do |table|
      if table.available?
        @available << table
      end
    end

    @server_id = session[:server_id]
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
    tip = params[:tip]['amount'].to_f
    party.update(paid: true, tip: tip)
    redirect to('/parties')
  end

  post '/parties' do
    party = Party.create(params[:party])
    redirect to("/parties/#{party.id}")
  end

  get '/parties/:id/edit' do |id|
    @tables = Teble.all
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
    id = session[:server_id]
    server = Server.find(id)
    @tips = server.todays_tips
    erb :tips
  end

  get '/tables/new' do
    erb :'/tables/new'
  end

  post '/tables/new' do
    if params[:table]['number'].is_a? Integer and params[:table]['seats'].is_a? Integer
      Teble.create(params['table'])
      redirect to('/index')
    else
      erb :tableoops
    end
  end

  get '/server/new' do
    erb :'server/new'
  end

  post '/server/new' do
    Server.create(params[:server])
    redirect to('/')
  end

  get '/server/:id/edit' do |id|
    @server = Server.find(id)
    erb :'server/edit'
  end

  patch '/server/:id' do |id|
    server = Server.find(id)
    server.update(params[:server])
    redirect to('/index')
  end

  delete '/server/:id' do |id|
    server = Server.find(id)
    server.destroy
    session[:server_id] = nil
    redirect to('/')
  end


  get '/logout' do
    session[:server_id] = nil
    redirect to('/')
  end

  get '/*' do
    redirect to('/')
  end

end
