class Bid < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  validates :amount, presence: true, :numericality => { :greater_than => 0 }
  validates :user_id, :product_id, presence: true

  def self.validate_user_input(params, user, product)
    error_messages = []
    
    if user.nil?
      error_messages << "User does not exist."
    end

    if !user.nil? && user.email == product.user.email
      error_messages << "You cannot bid on your items."
    end

    if params[:bid][:amount].to_f < product.minimum_bid
      error_messages << "Bid too low."
    end

    error_messages
  end
end
