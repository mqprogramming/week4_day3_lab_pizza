# THIS IS THE ROOT!

require( 'sinatra' )
require( 'sinatra/contrib/all' )
require( 'pry-byebug' )

require_relative('models/pizza_order')
also_reload('./models.*')

get '/pizza_orders' do
  # should be the PizzaOrder.all method
  # render some kind of view called index
  @orders = PizzaOrder.all
  erb(:index)
end

# we put it here because otherwise it will get '/pizza_orders/:id' first. We can put the .find get at the end
get '/pizza_orders/new' do
  erb(:new)
end

get '/pizza_orders/:id' do
  @order = PizzaOrder.find(params[:id])
  erb(:show)
end

post '/pizza_orders' do
   @order = PizzaOrder.new(params)
   @order.save
   erb(:create)
end

# post '/pizza_order/:id/delete' do
#   PizzaOrder.delete(params[:id].to_i)
#   erb(:destroy)
#   # redirect '/pizza_orders'
# end

post '/pizza_orders/delete_all' do
  PizzaOrder.delete_all
  # erb(:destroy)
  redirect '/pizza_orders'
end

get '/pizza_orders/:id/edit' do
  @order = PizzaOrder.find(params[:id].to_i)
  erb(:edit)
end

post '/pizza_orders/:id/update' do
  @order = PizzaOrder.find(params[:id].to_i)
  @order.update
  redirect '/pizza_orders'
end
