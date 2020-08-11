class UsersController < ApplicationController
  include UsersHelper
  include ApplicationHelper

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      current_user_set(@user.id)
      if visited_event.nil?
        redirect_to current_user
      else
        redirect_to visited_event
        visited_event_clear
      end
    else
      flash.now[:error] = @user.errors.full_messages
      render :new
    end
  end

  def sign_in
    @user = User.new
  end

  def logging
    @user = User.find_by_username(params[:user][:username])

    if @user.nil?
      current_user_set(@user.id)
      if visited_event.nil?
        redirect_to current_user
      else
        redirect_to visited_event
        visited_event_clear
      end
    else
      flash.now[@error] = ['Could not find the user.']
      @user = User.new({ username: params[:user][:username] })
      render 'users/sign_in'
    end
  end

  def sign_out
    user_sign_out
    redirect_to root_path
  end

  def notifications
    @pending = Invitation.pending_invitations(current_user.id)
  end

  def attend_event
    event = current_user.invitation_hosts
      .where(host_id: params[:host_id])
      .where(event_id: params[:event_id]).first.event
    register_to_event(event)
    redirect_to users_notifications_path
  end

  def decline_invitation
    event = current_user.invitation_hosts
      .where(host_id: params[:host_id])
      .where(event_id: params[:event_id]).first.event
    decline_registration(event)
    redirect_to users_notifications_path
  end
end
