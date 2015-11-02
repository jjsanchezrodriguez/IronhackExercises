class ContactsController < ApplicationController
  def home
    @contacts = Contact.all.order(:name)
  end

  def new
  end

  def create
    Contact.create(
      :name => params[:contact][:name],
      :address => params[:contact][:address],
      :phone => params[:contact][:phone],
      :email => params[:contact][:email],
    ).valid?

    redirect_to "/"
  end

  def detail
    @contact = Contact.find_by(id: params[:contact_id])
    if @contact.nil?
      render :contact_error
    else
      render :contact
    end
  end

  def delete
    Contact.find(params[:contact_id]).destroy
    redirect_to "/"
  end

  def favorite
    contact = Contact.find(params[:contact_id])
    contact.favorite ? contact.update(favorite: false) : contact.update(favorite: true)
    contact.save
    redirect_to "/"
  end

  def show_favorites
    @favorites = Contact.where(favorite: 't')
  end
end
