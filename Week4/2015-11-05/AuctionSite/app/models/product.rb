class Product < ActiveRecord::Base
  belongs_to :user
  has_many :bids, dependent: :destroy

  validates :title, :description, :deadline, presence: true

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
