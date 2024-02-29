class UsersController < ApplicationController
  def index
    @users = User.all
    render status: 200, json: { users: @users }
  end

  def create
    @user = User.new(user_params)
    # データベースに保存します
    if @user.save
      render json: { user: @user }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    @user = User.find_by(params.require(:user).permit(:email, :password))
    if @user
      render json: { user: @user }, status: :created
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :tag)
  end
end
