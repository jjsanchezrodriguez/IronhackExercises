# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Player.destroy_all
Tournament.destroy_all
Registration.destroy_all

puts "DB CLEANED"

t1 = Tournament.create(name: "Call of Duty")
t2 = Tournament.create(name: "Starcraft")
t3 = Tournament.create(name: "Counter Strike")
t4 = Tournament.create(name: "League of Legends")

p1 = Player.create(name: "Ondrej")
p2 = Player.create(name: "Michael")
p3 = Player.create(name: "Dan")
p4 = Player.create(name: "Bob")
p5 = Player.create(name: "Ben")
p6 = Player.create(name: "Matias")
p7 = Player.create(name: "Alex")
p8 = Player.create(name: "Superman")

r1 = Registration.create(player_id: p1.id, tournament_id: t1.id)
r2 = Registration.create(player_id: p2.id, tournament_id: t2.id)
r3 = Registration.create(player_id: p3.id, tournament_id: t3.id)
r4 = Registration.create(player_id: p4.id, tournament_id: t4.id)
r5 = Registration.create(player_id: p5.id, tournament_id: t4.id)
r6 = Registration.create(player_id: p6.id, tournament_id: t3.id)
r7 = Registration.create(player_id: p7.id, tournament_id: t2.id)
r8 = Registration.create(player_id: p8.id, tournament_id: t1.id)

puts "DB REPOPULATED"
