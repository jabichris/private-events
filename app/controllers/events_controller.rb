class EventsController < ApplicationController
  include EventsHelper
  include ApplicationHelper

  def index
    @events = Event.all
    @upcoming = current_user.nil? ? Event.upcoming_events : Event.upcoming_events(current_user)
    @previous = current_user.nil? ? Event.previous_events : Event.previous_events(current_user)
  end

  def show
    @event = Event.find(params[:id])
    redirect_to root_path unless can_see_event?
    @attendees_members = @event.attendees_members
    @uninvited_people = User.uninvited_users(@event)
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    @event.date = fill_event_date(@event)
    if @event.save
      redirect_to current_user
    else
      flash[:error] = @event.errors.full_messages
      render :new
    end
  end

  def attend_to_event
    if current_user.nil?
      flash[:error] = ['You need to sign in or sign up to register to this event']
      visited_event_set(params[:event][:id])
      redirect_to users_sign_in_path
    else
      @event = Event.find(params[:event][:id])
      register_to_event(@event)
      flash[:error] = @event.errors.full_messages if @event.errors.any?
      redirect_to @event
    end
  end

  def invite_to_event
    @event = Event.find(params[:event])
    invitee_id = params[:invitee].to_i
    if Event.add_new_invitation(@event, invitee_id)
      redirect_to @event
    else
      render :show
    end
  end

  private

  def fill_event_date(event)
    return nil if event.date.nil?

    DateTime.new(event.date.year,
                 event.date.month,
                 event.date.day,
                 params[:date_time].to_s.split(':')[0].to_i,
                 params[:date_time].to_s.split(':')[1].to_i, 0)
  end
end
