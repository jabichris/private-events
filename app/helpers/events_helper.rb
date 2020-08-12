module EventsHelper
  def event_params
    params.require(:event).permit(:date, :description, :title, :location, :accessibility)
  end

  def attendees?
    @event.attendees.count.positive? ? 'Attendees: ' : 'This event has not attendees yet'
  end

  def upcoming_events?
    @upcoming.count.positive? ? 'Upcoming Events:' : 'No upcoming events yet'
  end

  def previous_events?
    @previous.count.positive? ? 'Previous Events:' : 'No previous events'
  end

  def public_event?
    @event.accessibility ? 'Public' : 'Private'
  end

  def can_see_event?
    if current_user.nil?
      false
    elsif current_user.id == @event.creator_id ||
          @event.user_in_invited_list?(current_user.id)
      true
    end
  end
end
