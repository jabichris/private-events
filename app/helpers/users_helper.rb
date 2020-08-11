module UsersHelper
  def user_params
    params.require(:user).permit(:username)
  end

  def previous_created?
    @user.past_created_events.count.positive? ? 'Previous: ' : 'No previous events'
  end

  def upcoming_created?
    @user.upcoming_created_events.count.positive? ? 'Upcoming: ' : 'No upcomming events'
  end

  def previous?
    @user.past_events.count.positive? ? 'Previous: ' : 'No previous events'
  end

  def upcoming?
    @user.upcoming_events.count.positive? ? 'Upcoming: ' : 'No upcomming events'
  end

  def user_name_in_title
    if !current_user.nil? && current_user.id == @user.id
      "Welcome #{current_user.username}"
    else
      "Profile of #{@user.username}"
    end
  end

  def user_name_in_list
    if !current_user.nil? && @user.id == current_user.id
      'you'
    else
      @user.username
    end
  end
end
