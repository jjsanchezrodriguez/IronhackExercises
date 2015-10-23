require 'imdb'

class Crawler

  attr_reader :titles, :question, :answer, :random
  attr_accessor :query

  def initialize
    @query = nil
    @titles = []
    @question = nil
    @answer = nil
    @random = nil
  end

  def crawl
    search = Imdb::Search.new(@query).movies[0..20]
    check_for_empy_values(search)[0..8].each { |m| @titles << m }
  end

  def check_for_empy_values(search)
    search.select do |title| 
      !title.poster.nil? && 
      !title.director.empty?
    end
  end

  def random_selection
    @random = @titles[rand(@titles.size)]
  end

  def directed_by?
    random_selection
    director = @random.director[0]
    @question = "Which movie was filmed by #{director}?"
    @answer = @random.id
  end

  def what_year?
    random_selection
    year = @random.year
    @question = "What movie is from year #{year}?"
    @answer = @random.id
  end

  def what_actor?
    random_selection
    actor = @random.cast_members[rand(@random.cast_members.size)]
    @question = "What movie did #{actor} starred in?"
    @answer = @random.id
  end

end
