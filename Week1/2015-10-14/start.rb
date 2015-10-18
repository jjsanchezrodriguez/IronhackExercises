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

def load_rooms(gamedata)
  rooms = gamedata.map do |room|
    Room.new(room['name'],
             room['description'],
             room['description_visited'],
             room['items'],
             room['exits'])
  end
end

def new_game(pname)
  rooms = load_rooms(get_gamedata)
  a_player = Player.new(pname)
  a_game = Game.new(rooms, a_player)
  system "clear"

  a_game.play
end

def load_game

  file = File.open("savefile.json","r")
  json = JSON.load(file)
  file.close

  pname = json['playerdata']['name']
  pinv = json['playerdata']['inventory']
  ppos = json['playerdata']['position']
  pvis = json['playerdata']['visited']

  a_player = Player.new(pname, pinv, ppos, pvis)
  rooms = load_rooms(json['gamedata'])

  current_room = Room.new(json['cur_room']['name'],
                          json['cur_room']['description'],
                          json['cur_room']['description_visited'],
                          json['cur_room']['items'],
                          json['cur_room']['exits'],
                         )

  a_game = Game.new(rooms, a_player, current_room, json['sel_dir'])

  a_game.play
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
