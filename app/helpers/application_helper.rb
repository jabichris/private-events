module ApplicationHelper
  include SessionHelper
  def user_pending_invitations(user_id)
    Invitation.pending_invitations_count(user_id)
  end
end
