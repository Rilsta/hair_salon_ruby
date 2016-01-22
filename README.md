# Hair Salon
**By Riley Starnes**

## Project
Hair Salon is a Ruby application that uses Sinatra to display a webpage. PSQL
will be used for database storage.

## Objective
Salon owners will be able to add stylists and clients to a database for
later use. Salon owners will also be able to assign clients to stylists.

In PSQL:
CREATE DATABASE hair_salon;
CREATE TABLE stylists (id serial PRIMARY KEY, name varchar);
CREATE TABLE clients (id serial PRIMARY KEY, name varchar, stylist_id int);

## Installation
Git clone the following repository:
* https://github.com/Rilsta/hair_salon_ruby.git

## License
MIT License 2016
