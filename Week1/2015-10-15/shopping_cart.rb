require 'pry'
require 'colorize'

class ShoppingCart
  def initialize
    @items = [] 
    @sum = {}
    @qtities = {}
  end

  def add_item(item)
    @items << item
  end

  def show
    quantities
    discounts
    calculate
    total_sum = @sum.reduce(0) do |sum, (k,v)| 
      sum += v
    end
    @qtities.each do |name, qty|
      puts "#{qty.to_s.colorize( :background => :white, :color => :black)}  #{name}(s) #{@sum[name].to_s.colorize(:red)}"
    end
    puts "--------"
    puts "Total: #{total_sum.to_s.colorize( :background => :green, :color => :red )}"
  end

  def calculate
    @items.each do |item|
      if @sum.include?(item.name)
        @sum[item.name] += item.price
      else
        @sum[item.name] = item.price
      end
    end
  end

  def discounts
    @qtities.each do |name, qty|
      # every second apple is for free
      if name == 'apple' && qty > 1
        apples = @items.select do |item|
          item.name == 'apple'
        end
        apples[0..apples.size/2].each do |apple|
          apple.price = 0
        end
      # every third orange is free
      elsif name == 'orange' && qty > 2 
        oranges = @items.select do |item|
          item.name == 'orange'
        end
        oranges[0..oranges.size/3].each do |orange|
          orange.price = 0
        end
      elsif name == 'grape' && qty == 4
        free_banana = Banana.new
        free_banana.price = 0
        @qtities['banana'] += 1
        @items << free_banana
      end
    end

  end

  def quantities
    @items.each do |item|
      if !@qtities[item.name].nil?
        @qtities[item.name] += 1
      else
        @qtities[item.name] = 1 
      end
    end
  end
end

class Item
  attr_accessor :name, :price
  def initialize(name, price)
    @name = name
    @price = price 
  end
end

class Apple < Item
  def initialize
    super('apple', 10)
  end
end

class Banana < Item
  def initialize
    super('banana', 20)
  end
end

class Orange < Item
  def initialize
    super('orange', 5)
  end
end

class Grape < Item
  def initialize
    super('grape', 15)
  end
end

cart = ShoppingCart.new

4.times do
  cart.add_item(Apple.new)
end
3.times do 
  cart.add_item(Banana.new)
end
7.times do
  cart.add_item(Orange.new)
end
4.times do
  cart.add_item(Grape.new)
end
cart.show
