# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.all.each { |p| p.delete }
Bid.all.each { |b| b.delete }
User.destroy_all


puts "--- DB cleaned ---"

5.times do |u|

  user = User.new(name: Faker::Name.name, email: Faker::Internet.email )
  user.save

  3.times do |p|
    product = Product.new(user_id: user.id, title: Faker::Commerce.product_name, description: Faker::Lorem.sentence, deadline: Faker::Time.forward(rand(3..5)), minimum_bid: rand(4.00 .. 5.00).to_f.round(2))
    product.save

    2.times do |b|
      Bid.create(user_id: user.id, product_id: 3, amount: product.minimum_bid - rand(0.10 .. 0.80), created_at: Faker::Time.between(DateTime.now - 1, DateTime.now))
    end
  end

end

puids = Product.all.map { |p| p.id }

User.all.each do |u|
  u.bids.each do |b|
    pid = puids - u.products.map { |p| p.id }
    b.update(product_id: pid[rand(pid.count - 1)])
  end
end

Product.all[13].update(deadline: DateTime.yesterday)
