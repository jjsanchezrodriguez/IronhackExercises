require 'pry'
require 'json'
require './game'
require './room'
require './player'
require './gamedata'
require 'colorize'

def intro
  puts "--- Welcome to Game of Rooms ---".colorize(:red)

  puts "Pick an option"
  puts "(1) New game"
  puts "(2) Continue game"
  puts "(3) Quit game"

  input = gets.chomp.to_i
end

def load_rooms
  # Generate rooms into a list
  rooms = get_gamedata.each do |room|
    Room.new(room[:name],
             room[:description],
             room[:description_visited],
             room[:items],
             room[:exits])
  end
end

def new_game(pname)

  rooms = load_rooms
  a_player = Player.new(pname)

  a_game = Game.new(rooms, a_player)

  system "clear"

  a_game.play

end

def load_game
  savefile = IO.read("savefile")
  file = JSON.generate(savefile)

  pname = file[:playerdata.to_s]['name']
  pinv = file[:playerdata.to_s]['inventory']
  ppos = file[:playerdata.to_s]['position']
  pvis = file[:playerdata.to_s]['visited']
  
  a_player = Player.new(pname, pinv, ppos, pvis)

  rooms = file[:roomdata.to_s].map do |attr|
    Room.new(
      attr[:name.to_s]
    )
  end

  binding.pry
end

# Intro screen
input = intro
case input
when 1
  puts "Select your name:"
  pname = gets.chomp
  new_game(pname)
when 2
  load_game
when 3
  puts "quitting"
end

