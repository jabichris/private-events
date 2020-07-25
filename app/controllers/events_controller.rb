class EventsController < ApplicationController
  include EventsHelper
  include ApplicationHelper
  def new
    @event = Event.new
    end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to current_user
    else
      render :new
    end
  end
end
