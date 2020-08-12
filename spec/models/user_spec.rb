require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { User.new }
  let(:event) { Event.create(title: 'Event test', date: Date.today + 1) }
  let(:creator) { User.create(username: 'Creator test') }
  let(:user_1) { User.create(username: 'User test 1') }
  context 'When creating a new user:' do
    it 'is valid if it have a username.' do
      user.username = 'User test'
      expect(user).to be_valid
    end
    it 'is not valid if it dosn\'t have a username.' do
      expect(user).to_not be_valid
    end
  end
  context 'When saving a user:' do
    it 'saves if the user is valid' do
      user.username = 'User test'
      expect(user.save).to be true
    end
    it 'do not save, if the user is not valid' do
      expect(user.save).to be false
    end
  end
  context 'User relation with Events:' do
    it 'can create many events.' do
      t = User.reflect_on_association(:events)
      expect(t.macro).to eq(:has_many)
    end
    it 'can attend many events.' do
      t = User.reflect_on_association(:attended_events)
      expect(t.macro).to eq(:has_many)
    end
  end
  context 'User relation with Invitations:' do
    it 'can invite many invitees.' do
      t = User.reflect_on_association(:invitees)
      expect(t.macro).to eq(:has_many)
    end
    it 'can have many hosts that have invited him or her.' do
      t = User.reflect_on_association(:hosts)
      expect(t.macro).to eq(:has_many)
    end
  end
  context 'User upcoming events:' do
    before do
      creator.events.push event
      user_1.attended_events.push event
    end
    it 'show only the user next events to attend from today on' do
      expect(user_1.upcoming_events.count).to be 1
    end
  end
  context 'User past events:' do
    before do
      event.update(date: (Time.now + 5).to_s)
      creator.events.push event
      user_1.attended_events.push event
    end
    it 'show only the user past events that attended before today' do
      expect(user_1.past_events.count).to be 0
    end
  end
  context 'User created upcoming events:' do
    before do
      creator.events.push event
    end
    it 'show only the user next events to attend from today on' do
      expect(creator.upcoming_created_events.count).to be 1
    end
  end
  context 'User created past events:' do
    before do
      event.update(date: Time.now.to_s)
      creator.events.push event
    end
    it 'show only the user past events that attended before today' do
      expect(creator.past_created_events.count).to be 1
    end
  end
end
