class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :confirm_user, only: [:show, :favorites, :histroy, :leave, :update, :destroy]

  def index
    @users = User.search(params[:search])
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  PER = 10
  def favorites
    @user = User.find(params[:id])
    @favorites = @user.favorites.order(id: :desc).page(params[:page]).per(PER).reverse_order
  end

  def histroy
    @user = User.find(params[:id])
    if @browsing_histories = @user.browsing_histories.present?
      @browsing_histories = @user.browsing_histories
    end
  end

  def leave
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def destroy
    user = User.find(params[:id])
    if user.password == current_user.password
      user.destroy
      redirect_to home_path
    else
      render :leave
    end
  end

  def confirm_user
    user = User.find(params[:id])
    if user.id != current_user.id then
      redirect_to home_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :user_image)
  end
end
