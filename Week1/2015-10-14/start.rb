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
  rooms = get_gamedata.map do |room|
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

def hash_reconverter
end

def load_game

  file = File.open("savefile","r")
  json = JSON.load(file)
  file.close

  pname = json['playerdata']['name']
  pinv = json['playerdata']['inventory']
  ppos = json['playerdata']['position']
  pvis = json['playerdata']['visited']
  
  a_player = Player.new(pname, pinv, ppos, pvis)

  json['gamedata'].map do |sub|
    index = json['gamedata'].index(sub)
    sub['items'].reduce({}) do |memo, (k, v)|
      memo.tap { |m| m[k.to_sym] = v }
      json['gamedata'][index]['items'] = memo
    end
  end

  json['gamedata'].map do |sub|
    index = json['gamedata'].index(sub)
    sub['exits'].reduce({}) do |memo, (k, v)|
      memo.tap { |m| m[k.to_sym] = v }
      json['gamedata'][index]['exits'] = memo
    end
  end

  rooms = json['gamedata'].map do |item|
    Room.new(
      item['name'],
      item['description'],
      item['description_visited'],
      item['items'],
      item['exits'],
    )
  end


  current_room = Room.new(json['cur_room']['name'],
                         json['cur_room']['description'],
                         json['cur_room']['description_visited'],
                         json['cur_room']['items'],
                         json['cur_room']['exits']
                         )

  a_game = Game.new(rooms, a_player, current_room, json['sel_dir']) 
  binding.pry
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

