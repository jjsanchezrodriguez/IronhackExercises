# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Rake::Task["db:reset"]
Movie.destroy_all
Comment.destroy_all

puts "--- DB clean ---"

m1 = Movie.create(title: "Three Colors Blue",
             plot: "A woman struggles to find a way to live her life after the death of her husband and child.",
            year: 1993,
            poster: "http://ia.media-imdb.com/images/M/MV5BMjExNzQ5NTA1OV5BMl5BanBnXkFtZTcwMDkxMjcyMQ@@._V1_SX640_SY720_.jpg")

m2 = Movie.create(title: "Boyhood",
             plot: "The life of Mason, from early childhood to his arrival at college.",
            year: 2014,
            poster: "http://ia.media-imdb.com/images/M/MV5BMTYzNDc2MDc0N15BMl5BanBnXkFtZTgwOTcwMDQ5MTE@._V1_SX640_SY720_.jpg")

m3 = Movie.create(title: "Iron Man",
             plot: "After being held captive in an Afghan cave, an industrialist creates a unique weaponized suit of armor to fight evil.",
             year: 2008,
             poster: "http://ia.media-imdb.com/images/M/MV5BMTczNTI2ODUwOF5BMl5BanBnXkFtZTcwMTU0NTIzMw@@._V1_SX640_SY720_.jpg"
)

m4 = Movie.create(title: "Bicentennial Man",
             plot: "An android endeavors to become human as he gradually acquires emotions.",
             year: 1999,
             poster: "http://ia.media-imdb.com/images/M/MV5BMTczMzQyNTgxMF5BMl5BanBnXkFtZTYwMDY5MzI5._V1_SX640_SY720_.jpg"
            )
movies = [m1, m2, m3]
puts "--- DB repopulated with Movies ---"

movies.each do |m|
  m.comments.create(comment: "Hello")
  m.comments.create(comment: "There")
end

puts "--- DB repopulated with Comments ---"
