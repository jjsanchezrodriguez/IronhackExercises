require 'pry'
require './file_handler'
require './subtitle_block'
require './str_controller'

def start(filename, operator, shift)
  puts "File: #{filename}; Shift: #{shift} seconds."
  source_file = FileHandler.new(File.open(filename, "r"))
  raw_hash = file_parser(source_file.read)
  sub_blocks = subtitle_block_factory(raw_hash)
  controller = STRController.new(operator, shift, sub_blocks)

  controller.convert_to_date_obj
  controller.shift
  source_file.write(controller.convert_date_obj_to_s)
end

def file_parser(raw)
  file_data = make_raw(raw)
  temp_hash = make_hash(file_data)
  time_separator(temp_hash)
end

def time_separator(processed)
  sep = "-->"
  processed.each do |hash|
    hash.each do |k, v|
      if hash[:time].include?(sep)
        time = hash[:time].split(sep)
        time[0].strip!
        time[1].strip!
        hash[:time] = time
      end
    end
  end
end

def make_raw(raw)
  block = []
  processed = []
  raw.each do |line|

    if line.empty?
      processed << block
      block = []
    else
      block << line
    end

  end

  unless block.empty?
    processed << block
    block = []
  end

  return processed
end

def make_hash(processed)
  ary_of_hashes = [] 
  processed.each do |item|
    i = {id: nil, time: nil, text: nil}
    i[:id] = item[0]
    i[:time] = item[1]
    i[:text] = item[2]
    ary_of_hashes << i
  end
  return ary_of_hashes
end

def subtitle_block_factory(processed)
  sub_blocks = processed.map do |block|
      SubtitleBlock.new(block[:id], 
                        block[:time][0], 
                        block[:time][1],
                        block[:text])
    end
end

def parser(input)
  filename = input[0]
  operator = input[1][0]
  shift = input[1][1..-1].to_i


  return filename, operator, shift
end

parsed = parser(ARGV[0..1])
start(parsed[0], parsed[1], parsed[2])


