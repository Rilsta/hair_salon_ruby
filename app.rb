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

get('/stylists') do
  @stylists = Stylist.all
  erb(:stylists)
end

get('/stylists/new') do
  erb(:stylist_form)
end

post('/stylists') do
  name = params.fetch('name')
  Stylist.new({name: name, id: nil}).save
  @stylists = Stylist.all()
  erb(:success)
end

get('/stylists/:id') do
  @stylist = Stylist.find(params[:id].to_i)
  erb(:stylist)
end

get('/stylists/:id/edit') do
  @stylist = Stylist.find(params[:id].to_i)
  @stylists = Stylist.all()
  erb(:update_stylist)
end

patch('/stylists/:id') do
  @stylist = Stylist.find(params[:id].to_i)
  @stylist.update(params)
  @stylists = Stylist.all()
  erb(:stylists)
end

delete('/stylists/:id/delete') do
  @stylist = Stylist.find(params[:id].to_i)
  @stylist.delete
  @stylists = Stylist.all()
  erb(:stylists)
end

###############Clients

get("/stylists/:id") do
  @stylist = Stylist.find(params.fetch("id").to_i())
  erb(:stylist)
end

post('/clients') do
  name = params.fetch('name')
  stylist_id = params.fetch('stylist_id')
  @stylist = Stylist.find(stylist_id).to_i
  @client = Client.new({:id => nil, :name => name, :stylist_id => stylist_id})
  @client.save
  erb(:success2)
end

get('/clients/:id/edit') do
  @client = Client.find(params[:id].to_i)
  @stylist = Stylist.find(params.fetch("id").to_i())
  erb(:update_client)
end

patch('/clients/:id') do
  name = params.fetch("name")
  @clients = Client.all()
  @client = Client.find(params.fetch("id").to_i())
  @client.update({:name => name})
  @stylists = Stylist.all()
  erb(:stylists)
end

delete('/clients/:id/delete') do
  @client = Client.find(params[:id].to_i)
  @client.delete
  @stylists = Stylist.all()
  @clients = Client.all()
  erb(:stylists)
end
