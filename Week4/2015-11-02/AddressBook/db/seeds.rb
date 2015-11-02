# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Contact.destroy_all
puts "--- DB cleaned ---"

names = ["Ondrej", "Alex", "Valentin", "Victor", "Ben", "Maria", "Anais", "Pawel", "Baptiste", "Thor", "Llorenc" ]
(1..10).each do |i|
  Contact.create(name: names[i], address: "Whatever Road #{i}", phone: Array.new(10).map { |e| e = rand(1..10) }.join(''), email: "#{names[i]}@ironhack.com")
end
