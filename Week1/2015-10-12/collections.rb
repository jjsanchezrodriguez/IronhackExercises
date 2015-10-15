require 'pry'

class Home
  attr_reader(:name, :city, :capacity, :price)

  def initialize(name, city, capacity, price)
    @name = name
    @city = city
    @capacity = capacity
    @price = price
  end
end

# Iteration 1

homes = [
  Home.new("Nizar's place", "San Juan", 2, 42),
  Home.new("Fernando's place", "Seville", 5, 47),
  Home.new("Josh's place", "Pittsburgh", 3, 41),
  Home.new("Gonzalo's place", "Málaga", 2, 45),
  Home.new("Ariel's place", "San Juan", 4, 49),
  Home.new("Walter Whites place", "Albequerque", 11, 1000),
  Home.new("Nowhere", "Center of Galaxy", 0, 0),
  Home.new("BCN Place", "Barcelona", 8, 19),
  Home.new("Lenka's Place", "Prague", 2, 7),
]

# Iteration 2

homes.each do |home|
  puts home
end

# Iteration 3

puts "Type desired city: "
user_input = gets().chomp

selected_homes = homes.select do |home|
  home.city == user_input
end

puts "Desired citie(s): #{selected_homes}"

# Iteration 4

prices = homes.map do |home|
  home.price
end

total = prices.reduce(0) do |sum, price|
  sum += price
end

avg_price = total.to_f / homes.size
puts "Average housing price: #{avg_price}"  

# Iteration 5

puts "Enter your desired price:"
user_input = gets().chomp.to_i

best_priced_home = homes.find do |home|
  home.price <= user_input
end

puts "Best price for you is: #{best_priced_home.name} for #{best_priced_home.price} euros."



