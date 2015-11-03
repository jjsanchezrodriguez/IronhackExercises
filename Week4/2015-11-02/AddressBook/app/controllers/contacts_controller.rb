class ContactsController < ApplicationController
  def home
    @contacts = Contact.all.order(:name)
  end

  def new
  end

  def create
    Contact.create_contact(params)
    redirect_to "/"
  end

  def detail
    @contact = Contact.get_contact_details(params)
    render :contact_error if @contact.nil? else render :contact
  end

  def delete
    Contact.delete_contact(params)
    redirect_to "/"
  end

  def favorite
    Contact.favorite_contact_toggle(params)
    redirect_to "/"
  end

  def show_favorites
    @favorites = Contact.get_favorites
  end
end
