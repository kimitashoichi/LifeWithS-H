class ContactsController < ApplicationController
  before_action :authenticate_user!, only: [:index]
  before_action :confirm_admin_user, only: [:index]
  def index
    @contacts = Contact.all.order(id: :desc)
  end

  def user_contact_list
    @users_contacts = current_user.contacts
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def create
    @contact = Contact.new(contact_params)
    if user_signed_in?
      @contact.user_id = current_user.id
    else
      @contact.user_id = 0
    end

    if @contact.save && user_signed_in?
      redirect_to user_path(current_user.id), success: "Successfully sended your Contact."
    elsif @contact.save
      redirect_to home_path, success: "Successfully sended your Contact."
    else
      flash.now[:danger] = "Unfortunately failed to send."
      render :new
    end
  end

  def new
    @contact = Contact.new
  end

  def destroy
    contact = Contact.find(params[:id])
    contact.destroy
    if current_user.admin == true
      redirect_to contacts_path, success: "Successfully deleted that's Contact."
    else
      redirect_to user_path(current_user.id), success: "Successfully deleted your Contact."
    end
  end

  def confirm_admin_user
    user = current_user
    unless user.admin == true
      redirect_to user_path(user.id), danger: "Unfortunately failed to acsses."
    end
end

  private

  def contact_params
    params.require(:contact).permit(:contact_email, :contact_title, :contact_text, :user_id)
  end
end
