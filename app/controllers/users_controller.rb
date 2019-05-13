class UsersController < ApplicationController
  def index
    @users = User.all.order(id: :desc)
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
  end

  def favorites
  end

  def histroy
  end

  def leave
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  # 退会できなかった場合は退会ページにリダイレクトさせ、エラーメッセージを表示す流ようにする
  def destroy
    user = User.find(params[:id])
    if user.password == current_user.password
      user.destroy
      redirect_to '/'
    else
      render :leave
    end
  end

  def talk
  end

  private

  def user_params
    params.require(:user).permit(:email, :last_name, :first_name, :user_image)
  end
end
