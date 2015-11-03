class Contact < ActiveRecord::Base
  validates :name, presence: true, length: { minimum: 5, too_short: "At least 5 characters" }
  validates :address, presence: true
  validates :email, presence: true
  validates :phone, presence: true

  def self.create_contact(params)
    Contact.create(
      :name => params[:contact][:name],
      :address => params[:contact][:address],
      :phone => params[:contact][:phone],
      :email => params[:contact][:email],
    ).valid?
  end

  def self.get_contact_details(params)
    Contact.find_by(id: params[:contact_id])
  end

  def self.delete_contact(params)
    Contact.find(params[:contact_id]).destroy
  end

  def self.favorite_contact_toggle(params)
    contact = Contact.find(params[:contact_id])
    contact.favorite ? contact.update(favorite: false) : contact.update(favorite: true)
    contact.save
  end

  def self.get_favorites
    Contact.where(favorite: 't')
  end
end
