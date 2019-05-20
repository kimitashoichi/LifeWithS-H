class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :confirm_user, only: [:show, :favorites, :histroy, :leave, :update, :destroy]

  PER = 10
  def index
    @users = User.search(params[:search]).order(id: :desc).page(params[:page]).per(PER).reverse_order
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def favorites
    @user = User.find(params[:id])
    @favorites = @user.favorites.order(id: :desc).page(params[:page]).per(PER).reverse_order
  end

  def histroy
    @user = User.find(params[:id])
    if @browsing_histories = @user.browsing_histories.present?
      @browsing_histories = @user.browsing_histories.order(id: :desc).page(params[:page]).per(PER).reverse_order
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
    @user = User.find(params[:id])
    if @user.valid_password?(params[:user][:password])
      @user.destroy
      redirect_to home_path
    else
      flash.now[:danger] = "退会に失敗しました。パスワードを確認してください"
      render :leave
    end
  end

  def confirm_user
    user = User.find(params[:id])
    if current_user.admin != true
      if user.id != current_user.id
        redirect_to home_path, danger: "許可されていないアクションです"
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :user_image)
  end
end
