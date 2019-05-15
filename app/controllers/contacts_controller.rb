class ContactsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :confirm_admin_user, only: [:index]
  def index
    @contacts = Contact.all.order(id: :desc)
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def create
    contact = Contact.new(contact_params)
    if user_signed_in?
      contact.user_id = current_user.id
    else
      contact.user_id = 0
    end
    contact.save
    redirect_to home_path
  end

  def new
    @contact = Contact.new
  end

  def confirm_admin_user
    user = current_user
    unless user_signed_in? || user.admin == true
      redirect_to user_path(user.id)
    end
end

  private

  def contact_params
    params.require(:contact).permit(:contact_email, :contact_title, :contact_text, :user_id)
  end
end
