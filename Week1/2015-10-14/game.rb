# GAME OBJECT
VALID_DIRECTIONS = ["north", "south", "west", "east",
                    "n", "e", "s", "w"
                    ]

class Game

  attr_accessor :rooms

  def initialize(rooms, player, cur_room = nil, sel_dir = nil)
    # rooms - array of Room objects
    @rooms = rooms
    @player = player
    @sel_dir = sel_dir
    @cur_room = cur_room
  end

  def hash_converter(ary)
    converted = {}
    ary.each do |k, v|
      converted[k.to_s] = v
    end
    converted
  end

  def convert_room_objs_to_hash
    temp = []
    @rooms.each do |room|
      hash = {}
      hash['name'] = room.name
      hash['description'] = room.description
      hash['description_visited'] = room.description_visited
      hash['items'] = hash_converter(room.items)
      hash['exits'] = hash_converter(room.exits)
      #hash['exits'] = room.exits.keys.map { |e| e.to_s }
      temp << hash
    end
    return temp
  end

  def save
    player = {}
    player[:name] = @player.name
    player[:inventory] = @player.inventory
    player[:position] = @player.position
    player[:visited] = @player.visited

    data = {}
    data[:playerdata] = player
    data[:gamedata] = convert_room_objs_to_hash
    data[:sel_dir] = @sel_dir
    data[:cur_room] = {}
    data[:cur_room][:name] = @cur_room.name
    data[:cur_room][:description] = @cur_room.description
    data[:cur_room][:description_visited] = @cur_room.description_visited
    data[:cur_room][:items] = @cur_room.items
    data[:cur_room][:exits] = @cur_room.exits

    file = File.open("savefile","w")
    data_json = JSON.dump(data, file)
    file.close
  end

  def get_current_room
    valid_room = @rooms.find do |room|
      room.name == @player.position
    end
  end

  def direction_printer(room)
    exits = room.exits.keys.reduce("") do |str, key|
      str += key.to_s.upcase + ' '
    end
  end

  def enter
    @cur_room = get_current_room
    divider = "-" * @cur_room.name.size

    puts "\n"
    puts """
  |
  |
  |
    """
    puts @cur_room.name.colorize(:green)
    puts divider.colorize(:green)

    puts @cur_room.description

    if @player.visited.include?(@cur_room.name)
      puts @cur_room.description_visited
    end

    unless @cur_room.items.empty?
      @cur_room.items.each do |item, desc|
        puts desc
      end
    end

    puts "Directions: #{direction_printer(@cur_room)}".colorize(:background => :light_blue,
                                                     :color => :black)
    prompt
  end

  def input_validator(input)
    words = input.split

    words.each do |word|
      VALID_DIRECTIONS.include?(word) ? @sel_dir = word[0] : @sel_dir = nil
    end

    return input
  end

  def possible_to_enter(direction)
    @cur_room.exits.keys.include?(direction.to_sym)
  end

  def move
    @player.position = @cur_room.exits[@sel_dir.to_sym]
    unless @player.visited.include?(@cur_room.name)
      @player.visited << @cur_room.name
    end
  end

  def item_exists(obj, str)
    if obj.class == Player
      @player.inventory.include?(str.to_sym)
    else
      @cur_room.items.include?(str.to_sym)
    end
  end

  def pick_up(str)
    add = @cur_room.items.assoc(str.to_sym)
    @cur_room.items.delete(add[0].to_sym)
    @player.inventory[add[0]] = add[1]
  end

  def drop(str)
    drop = @player.inventory.assoc(str.to_sym)
    @player.inventory.delete(drop[0].to_sym)
    @cur_room.items[drop[0]] = drop[1]
  end

  def inv
    @player.inventory.each do |item, desc|
      puts "=> #{item}".colorize(:blue)
    end
  end


  def prompt
    print "> "
    input = input_validator(gets.chomp.downcase)

    case input
    when 'quit'
      quit
    when 'inv'
      inv
    when 'save'
      save
    end

    if input.include?('pick up')
      str = input[8..-1]
      if item_exists(@cur_room, str)
        pick_up(str)
        puts "=> picked up item '#{str}'".colorize(:blue)
      else
        puts "No item '#{str}'!".colorize(:red)
      end
    elsif input.include?('drop')
      str = input[5..-1]
      if item_exists(@player, str)
        drop(str)
        puts "=> Dropped item '#{str}'".colorize(:blue)
      else
        puts "No item '#{str}'!".colorize(:red)
      end
    end

    case @sel_dir
    when 'n'
      if possible_to_enter('n')
        move
      else
        puts "Can't go north.".colorize(:red)
        enter
      end
    when 's'
      if possible_to_enter('s')
        move
      else
        puts "Can't go south.".colorize(:red)
        enter
      end
    when 'e'
      if possible_to_enter('e')
        move
      else
        puts "Can't go east.".colorize(:red)
        enter
      end
    when 'w'
      if possible_to_enter('w')
        move
      else
        puts "Can't go west.".colorize(:red)
        enter
      end
    end


  end

  def play
    while true
      enter
    end
  end


  def quit
    exit(0)
  end
end
