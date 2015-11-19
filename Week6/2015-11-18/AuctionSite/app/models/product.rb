class Product < ActiveRecord::Base
  belongs_to :user
  has_many :bids, dependent: :destroy
  has_many :reviews, dependent: :destroy

  validates :title, :description, :deadline, :minimum_bid, presence: true

  def index
  end

  def new
    @product = Product.new
  end

  def show
  end

  def create
  end

  def destroy
  end
end
