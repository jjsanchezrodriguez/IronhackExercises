class Movie < ActiveRecord::Base
  has_many :comments
  def self.search_by_title(query)
    result = Movie.where("title like ?", "%#{query}%").limit(20)
    if result.any?
      result
    else
      Imdb::Search.new(query).movies[0..20]
    end
  end

  def self.create_from_imdb(id)
    imdb = Imdb::Movie.new(id)
    movie = Movie.create(
      id: Movie.last.id + 1,
      title: imdb.title,
      year: imdb.year,
      poster: imdb.poster,
      plot: imdb.plot
    )
    movie
  end
end
