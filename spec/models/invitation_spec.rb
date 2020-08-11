require 'rails_helper'

RSpec.describe Invitation, type: :model do
  let(:user) { User.new }
  let(:event) { Event.create(title: 'Event test', date: Date.today + 1) }
  let(:creator) { User.create(username: 'Creator test') }
  let(:user_1) { User.create(username: 'User test 1') }

  context 'Invitations relation with Users:' do
    it 'store many invitations for invitees.' do
      i = Invitation.reflect_on_association(:invitee)
      expect(i.macro).to eq(:belongs_to)
    end

    it 'store many invitations for hosts.' do
      i = Invitation.reflect_on_association(:host)
      expect(i.macro).to eq(:belongs_to)
    end
  end

  context 'Invitations relation with Events:' do
    it 'store many invitations per event.' do
      i = Invitation.reflect_on_association(:event)
      expect(i.macro).to eq(:belongs_to)
    end
  end

  context 'User pending invitations' do
    before do
      creator.events.push event
      invitation = Invitation.new
      invitation.host_id = creator.id
      invitation.invitee_id = user_1.id
      invitation.event_id = event.id
      invitation.status = 'pending'
      invitation.save
    end

    it 'show the user the number of invitations he or she has pending' do
      expect(Invitation.pending_invitations_count(user_1.id)).to be 1
    end

    it 'show a list of pending invitations for the user' do
      expect(Invitation.pending_invitations(user_1.id).first.creator_id).to be creator.id
    end
  end
end
