# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Vehicle.create([{:utility_class => 'Sedan'}, {:utility_class => 'Coupé'}, {:utility_class => 'Truck'}, {:utility_class => 'SUV'}])
Option.create([{:name => 'Sunroof', :description => 'Keeps the sun and rain off your dome'},{:name => 'Tinted Windows', :description => 'Keeps the sun and rain off your dome'},{:name => 'Leather Seats', :description => 'Makes your bum sweat in the summer'},{:name => 'Yellow Paint', :description => 'Go fast!'}])
makes = Make.create([{:brand => 'Toyota'}, {:brand => 'Honda'}, {:brand => 'Porsche'}, {:brand => 'Mercedes'},{:brand => 'BMW'}, {:brand => 'Audi'}, {:brand => 'Subaru'}, {:brand => 'Volkswagen'}])
Model.create([
  {:model_title => 'Sequoia', :make => makes[0]},
  {:model_title => '4Runner', :make => makes[0]},
  {:model_title => 'Camry', :make => makes[0]},
  {:model_title => 'Trueno', :make => makes[0]},
  {:model_title => 'Soarer', :make => makes[0]},
  {:model_title => 'Accord', :make => makes[1]},
  {:model_title => 'Civic', :make => makes[1]},
  {:model_title => 'Highlander', :make => makes[1]},
  {:model_title => 'Odessey', :make => makes[1]},
  {:model_title => 'Rav4', :make => makes[1]},
  {:model_title => '911', :make => makes[2]},
  {:model_title => '918', :make => makes[2]},
  {:model_title => 'Panamera', :make => makes[2]},
  {:model_title => 'Boxster', :make => makes[2]},
  {:model_title => '356', :make => makes[2]},
  {:model_title => '930', :make => makes[2]},
  {:model_title => 'A Class', :make => makes[3]},
  {:model_title => 'B Class', :make => makes[3]},
  {:model_title => 'C Class', :make => makes[3]},
  {:model_title => 'E Class', :make => makes[3]},
  {:model_title => 'S Class', :make => makes[3]},
  {:model_title => 'SL Class', :make => makes[3]},
  {:model_title => '1 Series', :make => makes[4]},
  {:model_title => '2 Series', :make => makes[4]},
  {:model_title => '3 Series', :make => makes[4]},
  {:model_title => '4 Series', :make => makes[4]},
  {:model_title => '1 Series M', :make => makes[4]},
  {:model_title => 'M2', :make => makes[4]},
  {:model_title => 'M3', :make => makes[4]},
  {:model_title => 'M4', :make => makes[4]},
  {:model_title => 'A3', :make => makes[5]},
  {:model_title => 'A4', :make => makes[5]},
  {:model_title => 'A5', :make => makes[5]},
  {:model_title => 'A6', :make => makes[5]},
  {:model_title => 'S3', :make => makes[5]},
  {:model_title => 'S4', :make => makes[5]},
  {:model_title => 'RS4', :make => makes[5]},
  {:model_title => 'GL', :make => makes[6]},
  {:model_title => 'Justy', :make => makes[6]},
  {:model_title => 'Outback', :make => makes[6]},
  {:model_title => 'Impreza', :make => makes[6]},
  {:model_title => 'Beetle', :make => makes[7]},
])