# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Concert.destroy_all
Comment.destroy_all

puts "-- destroyed data ---"

10.times do |i|
  concert = Concert.create(band: Faker::Company.name, venue: Faker::Lorem.word.capitalize + " Club", city: Faker::Address.city,                                                                                                                                      price: rand(2.20 .. 5.60), description: Faker::Lorem.sentences(5).join(' '),                                                                                                                                       date: Faker::Time.forward(rand(40..100), :evening))
  2.times do |c|
    Comment.create(concert_id: concert.id, comment: Faker::Lorem.sentences(3).join(' '))
  end
end

Concert.create(band: "New Order", venue: "CGB", city: "LA", price: 3.30, description: "Kicks ass", date: Date.today)
Concert.create(band: "Broken Social Scene", venue: "007", city: "Prague", price: 4.30, description: "Pretty good", date: Date.today + 2)

puts "--- DB refreshed ---"
