class Concert < ActiveRecord::Base
  cattr_reader :cities
  @@cities = [
            "Prague",
            "Amsterdam",
            "Barcelona",
            "New York",
            "Los Angeles",
            "Berlin"
            ]

  validates :band, presence: true, length: { minimum: 1, maximum: 100 }
  validates :venue, presence: true, length: { minimum: 1, maximum: 100 }
  validates :city, presence: true, inclusion: { in: @@cities } 
  validates :description, presence: true, length: { minimum: 1, maximum: 1024 }
  validates :price, numericality: true, presence: true
  validates :date, presence: true
  has_attached_file :poster, default_url: "http://robohash.org/nemooccaecatiaut.png?size=300x300&set=set1"
  validates_attachment_content_type :poster, content_type: /\Aimage\/.*\Z/

  has_many :comments, dependent: :destroy


  def self.today_concerts
    Concert.all.select do |c|
      c.date == Date.today
    end
  end

  def self.this_month_concerts
    Concert.all.select do |c|
      c.date > Date.today
    end
  end

  def self.search_by_price(price)
    concerts = Concert.all.select do |c|
      c.date > Date.today &&
      c.price <= price
    end
    concerts.sort { |c1, c2| c1.date <=> c2.date }
  end

  def self.search_by_popularity
    concerts = Concert.all.sort do |c1, c2|
      c2.comments.count <=> c1.comments.count
    end
    concerts[0, 10]
  end
end
