class UsersController < ApplicationController
  include UsersHelper
  include ApplicationHelper
  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      current_user_set(@user.id)
      redirect_to @current_user
    else
      render :new
    end
  end

  def sign_in
    @user = User.new
  end

  def logging
    @error = nil
    @user = User.find_by_username(params[:user][:username])

    if @user.nil? == false
      current_user_set(@user.id)
      redirect_to current_user
    else
      @error = 'Could not find the user.'
      @user = User.new({ username: params[:user][:username] })
      render 'users/sign_in'
    end
  end
end
