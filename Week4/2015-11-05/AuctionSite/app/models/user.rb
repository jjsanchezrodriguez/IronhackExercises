class User < ActiveRecord::Base
  has_many :products, dependent: :destroy
  has_many :bids

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true

  def new
  end
end
