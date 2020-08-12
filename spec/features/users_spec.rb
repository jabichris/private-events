# rubocop:disable Metrics/BlockLength
require 'rails_helper'

RSpec.feature 'Users', type: :feature, js: true do
  context 'Sign up for a new user:' do
    scenario 'should be succeful' do
      visit root_path
      click_link 'Sign up'
      within('form') do
        fill_in 'user_username', with: 'User 1 test'
      end
      click_button 'Sign up'
      expect(page).to have_content('Welcome User 1 test')
    end

    scenario 'should fail' do
      visit root_path
      click_link 'Sign up'
      within('form') do
        fill_in 'user_username', with: ''
      end
      click_button 'Sign up'
      expect(page).to have_content('Username can\'t be blank')
    end

    scenario 'should see the sign up form if he used \'here\' link from sign in page' do
      visit root_path
      click_link 'Sign in'
      click_link 'here'
      expect(page).to have_content('Sign up')
    end
  end

  context 'Sign in for a created user:' do
    before(:each) { User.create(username: 'User 1 test') }
    scenario 'should be succeful' do
      visit root_path
      click_link 'Sign in'
      within('form') do
        fill_in 'user_username', with: 'User 1 test'
      end
      click_button 'Sign in'
      expect(page).to have_content('Welcome User 1 test')
    end

    scenario 'should fail' do
      visit root_path
      click_link 'Sign in'
      within('form') do
        fill_in 'user_username', with: '123'
      end
      click_button 'Sign in'
      expect(page).to have_content('Could not find the user.')
    end
  end

  context 'Sign out for a created user:' do
    before(:each) { User.create(username: 'User 1 test') }
    scenario 'should be succeful' do
      visit root_path
      click_link 'Sign in'
      within('form') do
        fill_in 'user_username', with: 'User 1 test'
      end
      click_button 'Sign in'
      click_link 'Sign out'
      expect(page).to have_content('Welcome to Private Events')
    end
  end

  context 'User notifications' do
    before(:each) do
      u = User.create(username: 'User 1 test')
      u2 = User.create(username: 'User 2 test')
      e = Event.create(creator_id: u.id, title: 'Event 1', date: Time.now + 100)
      Invitation.create(host_id: u.id, invitee_id: u2.id, event_id: e.id, status: 'pending')
    end

    scenario 'Users with out notifications.' do
      visit root_path
      click_link 'Sign in'
      within('form') do
        fill_in 'user_username', with: 'User 1 test'
      end
      click_button 'Sign in'
      expect(page).to have_content('Notifications (0)')
    end

    scenario 'Users with 1 or more notifications.' do
      visit root_path
      click_link 'Sign in'
      within('form') do
        fill_in 'user_username', with: 'User 2 test'
      end
      click_button 'Sign in'
      click_link 'Notifications (1)'
      expect(page).to have_content('Event 1')
    end

    scenario 'User can accept invitations from the notification\'s page' do
      visit root_path
      click_link 'Sign in'
      within('form') do
        fill_in 'user_username', with: 'User 2 test'
      end
      click_button 'Sign in'
      click_link 'Notifications (1)'
      page.accept_confirm do
        click_link('Accept')
      end
      expect(page).to have_content('Notifications (0)')
    end

    scenario 'User can decline invitations from the notification\'s page' do
      visit root_path
      click_link 'Sign in'
      within('form') do
        fill_in 'user_username', with: 'User 2 test'
      end
      click_button 'Sign in'
      click_link 'Notifications (1)'
      page.accept_confirm do
        click_link('Decline')
      end
      expect(page).to have_content('Notifications (0)')
    end
  end
end
# rubocop:enable Metrics/BlockLength
