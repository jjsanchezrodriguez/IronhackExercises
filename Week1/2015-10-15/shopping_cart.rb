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
    calculate
    quantities
    #binding.pry
    @qtities.each do |name, qty|
      puts "##{qty}  #{name} #{@sum[name]}"
    end
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
  attr_reader :name, :price
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

cart = ShoppingCart.new
an_apple = Apple.new
cart.add_item(an_apple)

3.times do 
  cart.add_item(Banana.new)
end

cart.show

