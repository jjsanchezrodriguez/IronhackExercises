class Contact < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 5, too_short: "At least 5 characters" }
  validates :address, presence: true
  validates :email, presence: true
  validates :phone, presence: true
end
