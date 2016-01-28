require('sinatra')
require('sinatra/reloader')
require('./lib/client')
require('./lib/stylist')
require('pry')
require('pg')

DB = PG.connect({dbname: 'hair_salon'})

###########Stylists

get('/') do
  erb(:index)
end

get('/frollicle/add_stylists') do
  erb(:stylist_form)
end

post('/frollicle/add_stylists/new') do
  name = params.fetch('name')
  Stylist.new({name: name, id: nil}).save
  @stylists = Stylist.all()
  erb(:success)
end

get('/frollicle/view_stylists') do
  @stylists = Stylist.all
  erb(:stylist_list)
end

get('/frollicle/view_stylists/:id') do
  @stylist = Stylist.find(params[:id].to_i)
  erb(:stylist)
end

get('/frollicle/view_stylists/edit/:id') do
  @stylist = Stylist.find(params[:id].to_i)
  erb(:update_stylist)
end

patch('/frollicle/view_stylists/stylist_update/:id') do
  @stylist = Stylist.find(params[:id].to_i)
  @stylist.update(params)
  redirect ('/frollicle/view_stylists')
end

delete('/frollicle/view_stylists/delete/:id') do
  @stylist = Stylist.find(params[:id].to_i)
  @stylist.delete
  redirect ('/frollicle/view_stylists')
end

###############Clients

get("/frollicle/view_stylists/:id") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  erb(:stylist)
end

post('/frollicle/add_clients/new') do
  name = params.fetch('name')
  stylist_id = params.fetch('stylist_id')
  @stylist = Stylist.find(stylist_id).to_i
  @client = Client.new({:id => nil, :name => name, :stylist_id => stylist_id})
  @client.save
  erb(:success2)
end

get('/frollicle/view_clients/edit/:id') do
  @client = Client.find(params[:id].to_i)
  erb(:update_client)
end

patch('/frollicle/view_clients/client_update/:id') do
  @client = Client.find(params[:id].to_i)
  @client.update(params)
  redirect ('/frollicle/view_stylists')
end

get('/frollicle/view_clients/delete/:id') do
  @client = Client.find(params[:id].to_i)
  @client.delete
   redirect ('/frollicle/view_stylists')
end
