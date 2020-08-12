class WelcomeController < ApplicationController
  include ApplicationHelper

  def show
    @upcoming = current_user.nil? ? Event.upcoming_events : Event.upcoming_events(current_user)
  end
end
