# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Player.destroy_all
Match.destroy_all

players = [
p1 = Player.create(name: Faker::Name.name),
p2 = Player.create(name: Faker::Name.name),
p3 = Player.create(name: Faker::Name.name),
p4 = Player.create(name: Faker::Name.name),
p5 = Player.create(name: Faker::Name.name),
p6 = Player.create(name: Faker::Name.name),
p7 = Player.create(name: Faker::Name.name),
p8 = Player.create(name: Faker::Name.name),
p9 = Player.create(name: Faker::Name.name),
p10 = Player.create(name: Faker::Name.name),
p11 = Player.create(name: Faker::Name.name),
p12 = Player.create(name: Faker::Name.name)
]

races = ["Zerg", "Protos", "Terran"]

100.times do
  sub = players.dup
  Match.create(winner_faction: races[0], loser_faction: races[1], duration: rand(200), winner_id: sub.delete_at(rand(sub.length - 1)).id, loser_id: sub.delete_at(rand(sub.length - 1)).id, date: Faker::Date.backward(20))
  Match.create(winner_faction: races[1], loser_faction: races[0], duration: rand(200), winner_id: sub.delete_at(rand(sub.length - 1)).id, loser_id: sub.delete_at(rand(sub.length - 1)).id, date: Faker::Date.backward(20))
  Match.create(winner_faction: races[0], loser_faction: races[2], duration: rand(200), winner_id: sub.delete_at(rand(sub.length - 1)).id, loser_id: sub.delete_at(rand(sub.length - 1)).id, date: Faker::Date.backward(20))
  Match.create(winner_faction: races[2], loser_faction: races[0], duration: rand(200), winner_id: sub.delete_at(rand(sub.length - 1)).id, loser_id: sub.delete_at(rand(sub.length - 1)).id, date: Faker::Date.backward(20))
  Match.create(winner_faction: races[2], loser_faction: races[1], duration: rand(200), winner_id: sub.delete_at(rand(sub.length - 1)).id, loser_id: sub.delete_at(rand(sub.length - 1)).id, date: Faker::Date.backward(20))
  Match.create(winner_faction: races[1], loser_faction: races[2], duration: rand(200), winner_id: sub.delete_at(rand(sub.length - 1)).id, loser_id: sub.delete_at(rand(sub.length - 1)).id, date: Faker::Date.backward(20))
  sub.clear
end

150.times do
  Match.all[rand(Match.count - 1)].destroy
end
