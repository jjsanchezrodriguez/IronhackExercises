class Concert < ActiveRecord::Base
  validates :band, presence: true, length: { minimum: 1, maximum: 100 }
  validates :venue, presence: true, length: { minimum: 1, maximum: 100 }
  validates :city, presence: true, length: { minimum: 1, maximum: 256 }
  validates :description, presence: true, length: { minimum: 1, maximum: 1024 }
  validates :price, numericality: true, presence: true
  validates :date, presence: true

  has_many :comments, dependent: :destroy

  def self.today_concerts
    Concert.all.select do |c|
      c.date == Date.today
    end
  end

  def self.this_month_concerts
    concerts = Concert.all.select do |c|
      c.date.month == Date.today.month && 
        c.date.year == Date.today.year &&
        c.date.day >= Date.today.day
    end
  end
end
