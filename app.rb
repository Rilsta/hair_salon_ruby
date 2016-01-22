require('sinatra')
require('sinatra/reloader')
require('./lib/client')
require('./lib/stylist')
require('pry')
require('pg')

DB = PG.connect({dbname: 'hair_salon'})

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
